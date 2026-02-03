#ifndef SCRIBBLE_LEXER_H
#define SCRIBBLE_LEXER_H

#include <string>
#include <vector>

enum class TokenType {
    // Literals
    NUMBER,
    STRING,
    IDENTIFIER,
    
    // Keywords
    IF,
    ELSE,
    LOOP,
    REPEAT,
    FUNCTION,
    RETURN,
    OUTPUT,
    INPUT,
    
    // Operators
    PLUS,
    MINUS,
    STAR,
    SLASH,
    EQUALS,
    EQUAL_EQUAL,
    NOT_EQUAL,
    LESS,
    GREATER,
    LESS_EQUAL,
    GREATER_EQUAL,
    
    // Punctuation
    LPAREN,
    RPAREN,
    LBRACKET,
    RBRACKET,
    LBRACE,
    RBRACE,
    COMMA,
    DOT,
    COLON,
    
    // Comment
    COMMENT,
    
    // Special
    END_OF_FILE,
    ERROR
};

struct Token {
    TokenType type;
    std::string value;
    int line;
    int column;
};

class Lexer {
public:
    explicit Lexer(const std::string& source);
    std::vector<Token> tokenize();
    
private:
    std::string source;
    size_t position;
    int line;
    int column;
    
    char current();
    char peek();
    void advance();
    void skip_whitespace();
    Token read_number();
    Token read_string();
    Token read_identifier();
    Token read_comment();
};

#endif // SCRIBBLE_LEXER_H
