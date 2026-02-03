#include "parser.h"
#include <stdexcept>

Parser::Parser(const std::vector<Token>& tokens)
    : tokens(tokens), current(0) {}

Token Parser::peek() {
    if (current < tokens.size()) {
        return tokens[current];
    }
    return tokens.back(); // Return EOF
}

Token Parser::advance() {
    Token token = peek();
    if (current < tokens.size()) {
        current++;
    }
    return token;
}

bool Parser::match(TokenType type) {
    if (peek().type == type) {
        advance();
        return true;
    }
    return false;
}

std::shared_ptr<Program> Parser::parse() {
    auto program = std::make_shared<Program>();
    
    while (peek().type != TokenType::END_OF_FILE) {
        auto stmt = parse_statement();
        if (stmt) {
            program->statements.push_back(stmt);
        }
    }
    
    return program;
}

StmtPtr Parser::parse_statement() {
    switch (peek().type) {
        case TokenType::IF:
            return parse_if();
        case TokenType::LOOP:
            return parse_loop();
        case TokenType::OUTPUT:
            return parse_output();
        case TokenType::FUNCTION:
            return parse_function_def();
        default:
            advance();
            return nullptr;
    }
}

StmtPtr Parser::parse_if() {
    advance(); // consume 'if'
    
    auto if_stmt = std::make_shared<IfStatement>();
    if_stmt->condition = parse_expression();
    
    while (peek().type != TokenType::ELSE && 
           peek().type != TokenType::END_OF_FILE &&
           peek().type != TokenType::LOOP) {
        auto stmt = parse_statement();
        if (stmt) if_stmt->then_branch.push_back(stmt);
    }
    
    if (match(TokenType::ELSE)) {
        while (peek().type != TokenType::END_OF_FILE &&
               peek().type != TokenType::LOOP) {
            auto stmt = parse_statement();
            if (stmt) if_stmt->else_branch.push_back(stmt);
        }
    }
    
    return if_stmt;
}

StmtPtr Parser::parse_loop() {
    advance(); // consume 'loop'
    
    auto loop_stmt = std::make_shared<LoopStatement>();
    loop_stmt->repeat_count = 0;
    
    while (peek().type != TokenType::LOOP &&
           peek().type != TokenType::END_OF_FILE) {
        auto stmt = parse_statement();
        if (stmt) loop_stmt->body.push_back(stmt);
    }
    
    if (match(TokenType::LOOP)) {
        if (match(TokenType::REPEAT) && match(TokenType::EQUALS)) {
            if (peek().type == TokenType::NUMBER) {
                loop_stmt->repeat_count = std::stoi(advance().value);
            }
        }
    }
    
    return loop_stmt;
}

StmtPtr Parser::parse_output() {
    advance(); // consume 'output'
    
    auto output_stmt = std::make_shared<OutputStatement>();
    
    if (match(TokenType::LBRACKET)) {
        output_stmt->value = parse_expression();
        match(TokenType::RBRACKET);
    }
    
    return output_stmt;
}

StmtPtr Parser::parse_function_def() {
    advance(); // consume 'function'
    
    auto func_def = std::make_shared<FunctionDef>();
    
    if (peek().type == TokenType::IDENTIFIER) {
        func_def->name = advance().value;
    }
    
    match(TokenType::LPAREN);
    while (peek().type == TokenType::IDENTIFIER) {
        func_def->params.push_back(advance().value);
        if (!match(TokenType::COMMA)) break;
    }
    match(TokenType::RPAREN);
    
    match(TokenType::LBRACE);
    while (peek().type != TokenType::RBRACE &&
           peek().type != TokenType::END_OF_FILE) {
        auto stmt = parse_statement();
        if (stmt) func_def->body.push_back(stmt);
    }
    match(TokenType::RBRACE);
    
    return func_def;
}

ExprPtr Parser::parse_expression() {
    return parse_primary();
}

ExprPtr Parser::parse_primary() {
    Token token = peek();
    
    switch (token.type) {
        case TokenType::NUMBER: {
            advance();
            auto lit = std::make_shared<NumberLiteral>();
            lit->value = std::stod(token.value);
            return lit;
        }
        case TokenType::STRING: {
            advance();
            auto lit = std::make_shared<StringLiteral>();
            lit->value = token.value;
            return lit;
        }
        case TokenType::IDENTIFIER: {
            advance();
            auto ident = std::make_shared<Identifier>();
            ident->name = token.value;
            return ident;
        }
        default:
            advance();
            return nullptr;
    }
}
