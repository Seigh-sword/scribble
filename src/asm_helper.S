.text
.global asm_func
.type asm_func, @function
asm_func:
    pushq %rbp
    movq %rsp, %rbp
    movl $7, %eax
    popq %rbp
    ret
