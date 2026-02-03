#ifndef SCRIBBLE_PARSER_H
#define SCRIBBLE_PARSER_H

#include "lexer.h"
#include <memory>
#include <vector>

// Forward declarations
struct ASTNode;
struct Program;
struct Statement;
struct Expression;

using ASTPtr = std::shared_ptr<ASTNode>;
using StmtPtr = std::shared_ptr<Statement>;
using ExprPtr = std::shared_ptr<Expression>;

// Base AST Node
struct ASTNode {
    virtual ~ASTNode() = default;
    int line;
    int column;
};

// Expression nodes
struct Expression : public ASTNode {
    virtual ~Expression() = default;
};

struct NumberLiteral : public Expression {
    double value;
};

struct StringLiteral : public Expression {
    std::string value;
};

struct Identifier : public Expression {
    std::string name;
};

struct BinaryOp : public Expression {
    TokenType op;
    ExprPtr left;
    ExprPtr right;
};

struct FunctionCall : public Expression {
    std::string name;
    std::vector<ExprPtr> args;
};

// Statement nodes
struct Statement : public ASTNode {
    virtual ~Statement() = default;
};

struct IfStatement : public Statement {
    ExprPtr condition;
    std::vector<StmtPtr> then_branch;
    std::vector<StmtPtr> else_branch;
};

struct LoopStatement : public Statement {
    std::vector<StmtPtr> body;
    int repeat_count;
};

struct OutputStatement : public Statement {
    ExprPtr value;
};

struct FunctionDef : public Statement {
    std::string name;
    std::vector<std::string> params;
    std::vector<StmtPtr> body;
};

struct Program : public ASTNode {
    std::vector<StmtPtr> statements;
};

// Parser
class Parser {
public:
    explicit Parser(const std::vector<Token>& tokens);
    std::shared_ptr<Program> parse();
    
private:
    std::vector<Token> tokens;
    size_t current;
    
    Token peek();
    Token advance();
    bool match(TokenType type);
    StmtPtr parse_statement();
    StmtPtr parse_if();
    StmtPtr parse_loop();
    StmtPtr parse_output();
    StmtPtr parse_function_def();
    ExprPtr parse_expression();
    ExprPtr parse_primary();
};

#endif // SCRIBBLE_PARSER_H
