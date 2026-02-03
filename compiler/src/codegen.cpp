#include "codegen.h"
#include <iostream>

CodeGenerator::CodeGenerator(std::shared_ptr<Program> ast)
    : ast(ast), indent_level(0) {}

void CodeGenerator::emit(const std::string& code) {
    output << get_indent() << code << "\n";
}

void CodeGenerator::indent() {
    indent_level++;
}

void CodeGenerator::dedent() {
    if (indent_level > 0) indent_level--;
}

std::string CodeGenerator::get_indent() {
    return std::string(indent_level * 4, ' ');
}

std::string CodeGenerator::generate_cpp() {
    output.str("");
    indent_level = 0;
    
    emit("#include <iostream>");
    emit("#include <string>");
    emit("");
    emit("int main() {");
    indent();
    
    for (const auto& stmt : ast->statements) {
        generate_stmt(stmt);
    }
    
    dedent();
    emit("}");
    emit("return 0;");
    
    return output.str();
}

std::string CodeGenerator::generate_c() {
    output.str("");
    indent_level = 0;
    
    emit("#include <stdio.h>");
    emit("#include <stdlib.h>");
    emit("");
    emit("int main() {");
    indent();
    
    for (const auto& stmt : ast->statements) {
        generate_stmt(stmt);
    }
    
    dedent();
    emit("return 0;");
    emit("}");
    
    return output.str();
}

std::string CodeGenerator::generate_asm() {
    output.str("");
    indent_level = 0;
    
    emit(".text");
    emit(".global main");
    emit("main:");
    indent();
    emit("pushq %rbp");
    emit("movq %rsp, %rbp");
    emit("movl $0, %eax");
    emit("popq %rbp");
    emit("ret");
    
    return output.str();
}

std::string CodeGenerator::generate_expr(ExprPtr expr) {
    if (!expr) return "0";
    
    if (auto num = std::dynamic_pointer_cast<NumberLiteral>(expr)) {
        return std::to_string((long long)num->value);
    } else if (auto str = std::dynamic_pointer_cast<StringLiteral>(expr)) {
        return "\"" + str->value + "\"";
    } else if (auto ident = std::dynamic_pointer_cast<Identifier>(expr)) {
        return ident->name;
    }
    
    return "0";
}

std::string CodeGenerator::generate_stmt(StmtPtr stmt) {
    if (!stmt) return "";
    
    if (auto out = std::dynamic_pointer_cast<OutputStatement>(stmt)) {
        emit("std::cout << " + generate_expr(out->value) + " << std::endl;");
    } else if (auto loop = std::dynamic_pointer_cast<LoopStatement>(stmt)) {
        emit("for (int i = 0; i < " + std::to_string(loop->repeat_count) + "; i++) {");
        indent();
        for (const auto& body_stmt : loop->body) {
            generate_stmt(body_stmt);
        }
        dedent();
        emit("}");
    } else if (auto if_stmt = std::dynamic_pointer_cast<IfStatement>(stmt)) {
        emit("if (" + generate_expr(if_stmt->condition) + ") {");
        indent();
        for (const auto& then_stmt : if_stmt->then_branch) {
            generate_stmt(then_stmt);
        }
        dedent();
        if (!if_stmt->else_branch.empty()) {
            emit("} else {");
            indent();
            for (const auto& else_stmt : if_stmt->else_branch) {
                generate_stmt(else_stmt);
            }
            dedent();
        }
        emit("}");
    }
    
    return "";
}
