section .data
    message: db 0x49, 0x20, 0x72, 0x65, 0x61, 0x6C, 0x6C, 0x79, 0x20, 0x6C, 0x69, 0x6B, 0x65, 0x20, 0x67, 0x61, 0x6D, 0x65, 0x73, 0x2E
    msg_len equ $ - message

    initial_key equ 0xAA
    seed equ 0x13

section .bss
    buffer: resb msg_len

section .text
    global _start

_start:
    mov rsi, message
    mov rdi, buffer
    mov rcx, msg_len
    mov r8b, initial_key
    mov r9b, seed

loop_jsxs:
    cmp rcx, 0
    je done_jsxs

    mov al, byte [rsi]
    xor al, r8b
    mov byte [rdi], al

    add r8b, r9b

    inc rsi
    inc rdi
    dec rcx
    jmp loop_jsxs

done_jsxs:
    mov rax, 1
    mov rdi, 1
    mov rsi, buffer
    mov rdx, msg_len
    dec rdx
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall