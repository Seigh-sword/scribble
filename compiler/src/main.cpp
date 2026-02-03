#include <iostream>
#include <fstream>
#include <sstream>
#include "lexer.h"
#include "parser.h"
#include "codegen.h"

void print_usage(const char* program) {
    std::cerr << "Usage: " << program << " <input.scrib> [-o <output>] [--lang cpp|c|asm]\n";
    std::cerr << "  --lang cpp   : Generate C++ (default)\n";
    std::cerr << "  --lang c     : Generate C\n";
    std::cerr << "  --lang asm   : Generate Assembly (x86-64)\n";
}

int main(int argc, char* argv[]) {
    if (argc < 2) {
        print_usage(argv[0]);
        return 1;
    }
    
    std::string input_file = argv[1];
    std::string output_file;
    std::string lang = "cpp";
    
    for (int i = 2; i < argc; i++) {
        if (std::string(argv[i]) == "-o" && i + 1 < argc) {
            output_file = argv[++i];
        } else if (std::string(argv[i]) == "--lang" && i + 1 < argc) {
            lang = argv[++i];
        }
    }
    
    // Read input file
    std::ifstream file(input_file);
    if (!file.is_open()) {
        std::cerr << "Error: Cannot open file " << input_file << "\n";
        return 1;
    }
    
    std::stringstream buffer;
    buffer << file.rdbuf();
    std::string source = buffer.str();
    file.close();
    
    // Lexical analysis
    Lexer lexer(source);
    auto tokens = lexer.tokenize();
    
    // Parsing
    Parser parser(tokens);
    auto ast = parser.parse();
    
    // Code generation
    CodeGenerator codegen(ast);
    std::string generated_code;
    
    if (lang == "cpp") {
        generated_code = codegen.generate_cpp();
    } else if (lang == "c") {
        generated_code = codegen.generate_c();
    } else if (lang == "asm") {
        generated_code = codegen.generate_asm();
    } else {
        std::cerr << "Error: Unknown language " << lang << "\n";
        return 1;
    }
    
    // Write output
    if (output_file.empty()) {
        output_file = input_file.substr(0, input_file.rfind('.'));
        if (lang == "cpp") {
            output_file += ".cpp";
        } else if (lang == "c") {
            output_file += ".c";
        } else {
            output_file += ".s";
        }
    }
    
    std::ofstream out(output_file);
    if (!out.is_open()) {
        std::cerr << "Error: Cannot open output file " << output_file << "\n";
        return 1;
    }
    
    out << generated_code;
    out.close();
    
    std::cout << "✓ Compiled " << input_file << " -> " << output_file << "\n";
    return 0;
}
