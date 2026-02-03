#ifndef SCRIBBLE_CODEGEN_H
#define SCRIBBLE_CODEGEN_H

#include "parser.h"
#include <string>
#include <sstream>

class CodeGenerator {
public:
    explicit CodeGenerator(std::shared_ptr<Program> ast);
    std::string generate_cpp();
    std::string generate_c();
    std::string generate_asm();
    
private:
    std::shared_ptr<Program> ast;
    std::stringstream output;
    int indent_level;
    
    void emit(const std::string& code);
    void indent();
    void dedent();
    std::string generate_expr(ExprPtr expr);
    std::string generate_stmt(StmtPtr stmt);
    std::string get_indent();
};

#endif // SCRIBBLE_CODEGEN_H
