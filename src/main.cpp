#include <iostream>

extern "C" int c_func();
extern "C" int asm_func();

int main() {
    std::cout << "Hello from C++ main\n";
    int a = c_func();
    int b = asm_func();
    std::cout << "c_func returned " << a << "\n";
    std::cout << "asm_func returned " << b << "\n";
    return 0;
}
