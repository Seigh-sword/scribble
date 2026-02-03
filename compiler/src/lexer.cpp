#include "lexer.h"
#include <cctype>
#include <stdexcept>

Lexer::Lexer(const std::string& source)
    : source(source), position(0), line(1), column(1) {}

char Lexer::current() {
    if (position >= source.length()) return '\0';
    return source[position];
}

char Lexer::peek() {
    if (position + 1 >= source.length()) return '\0';
    return source[position + 1];
}

void Lexer::advance() {
    if (position < source.length()) {
        if (source[position] == '\n') {
            line++;
            column = 1;
        } else {
            column++;
        }
        position++;
    }
}

void Lexer::skip_whitespace() {
    while (std::isspace(current())) {
        advance();
    }
}

Token Lexer::read_number() {
    int start_line = line;
    int start_col = column;
    std::string number;
    
    while (std::isdigit(current()) || current() == '.') {
        number += current();
        advance();
    }
    
    Token token;
    token.type = TokenType::NUMBER;
    token.value = number;
    token.line = start_line;
    token.column = start_col;
    return token;
}

Token Lexer::read_string() {
    int start_line = line;
    int start_col = column;
    advance(); // Skip opening quote
    
    std::string string_val;
    while (current() != '"' && current() != '\0') {
        string_val += current();
        advance();
    }
    
    if (current() == '"') {
        advance(); // Skip closing quote
    }
    
    Token token;
    token.type = TokenType::STRING;
    token.value = string_val;
    token.line = start_line;
    token.column = start_col;
    return token;
}

Token Lexer::read_identifier() {
    int start_line = line;
    int start_col = column;
    std::string ident;
    
    while (std::isalnum(current()) || current() == '_') {
        ident += current();
        advance();
    }
    
    // Check keywords
    TokenType type = TokenType::IDENTIFIER;
    if (ident == "if") type = TokenType::IF;
    else if (ident == "else") type = TokenType::ELSE;
    else if (ident == "loop") type = TokenType::LOOP;
    else if (ident == "repeat") type = TokenType::REPEAT;
    else if (ident == "function") type = TokenType::FUNCTION;
    else if (ident == "return") type = TokenType::RETURN;
    else if (ident == "output") type = TokenType::OUTPUT;
    else if (ident == "input") type = TokenType::INPUT;
    
    Token token;
    token.type = type;
    token.value = ident;
    token.line = start_line;
    token.column = start_col;
    return token;
}

Token Lexer::read_comment() {
    int start_line = line;
    int start_col = column;
    
    advance(); advance(); // Skip >>
    std::string comment;
    
    while (!(current() == '<' && peek() == '<') && current() != '\0') {
        comment += current();
        advance();
    }
    
    if (current() == '<' && peek() == '<') {
        advance(); advance(); // Skip <<
    }
    
    Token token;
    token.type = TokenType::COMMENT;
    token.value = comment;
    token.line = start_line;
    token.column = start_col;
    return token;
}

std::vector<Token> Lexer::tokenize() {
    std::vector<Token> tokens;
    
    while (current() != '\0') {
        skip_whitespace();
        
        if (current() == '\0') break;
        
        // Comments
        if (current() == '>' && peek() == '>') {
            tokens.push_back(read_comment());
            continue;
        }
        
        // Numbers
        if (std::isdigit(current())) {
            tokens.push_back(read_number());
            continue;
        }
        
        // Strings
        if (current() == '"') {
            tokens.push_back(read_string());
            continue;
        }
        
        // Identifiers and keywords
        if (std::isalpha(current()) || current() == '_') {
            tokens.push_back(read_identifier());
            continue;
        }
        
        // Operators and punctuation
        Token token;
        token.line = line;
        token.column = column;
        
        switch (current()) {
            case '+': token.type = TokenType::PLUS; break;
            case '-': token.type = TokenType::MINUS; break;
            case '*': token.type = TokenType::STAR; break;
            case '/': token.type = TokenType::SLASH; break;
            case '=':
                if (peek() == '=') {
                    token.type = TokenType::EQUAL_EQUAL;
                    advance();
                } else {
                    token.type = TokenType::EQUALS;
                }
                break;
            case '!':
                if (peek() == '=') {
                    token.type = TokenType::NOT_EQUAL;
                    advance();
                } else {
                    token.type = TokenType::ERROR;
                }
                break;
            case '<':
                if (peek() == '=') {
                    token.type = TokenType::LESS_EQUAL;
                    advance();
                } else {
                    token.type = TokenType::LESS;
                }
                break;
            case '>':
                if (peek() == '=') {
                    token.type = TokenType::GREATER_EQUAL;
                    advance();
                } else {
                    token.type = TokenType::GREATER;
                }
                break;
            case '(': token.type = TokenType::LPAREN; break;
            case ')': token.type = TokenType::RPAREN; break;
            case '[': token.type = TokenType::LBRACKET; break;
            case ']': token.type = TokenType::RBRACKET; break;
            case '{': token.type = TokenType::LBRACE; break;
            case '}': token.type = TokenType::RBRACE; break;
            case ',': token.type = TokenType::COMMA; break;
            case '.': token.type = TokenType::DOT; break;
            case ':': token.type = TokenType::COLON; break;
            default:
                token.type = TokenType::ERROR;
        }
        
        token.value = current();
        tokens.push_back(token);
        advance();
    }
    
    Token eof;
    eof.type = TokenType::END_OF_FILE;
    eof.line = line;
    eof.column = column;
    tokens.push_back(eof);
    
    return tokens;
}
