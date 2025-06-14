section .data
    encrypted_message: db 0xEF, 0xDD, 0x8A, 0xBF, 0xCE, 0xD1, 0xC3, 0xC5, 0xCE, 0xC0, 0xC6, 0xD4, 0xD4, 0xD7, 0xDA, 0xE7, 0xED, 0xE4, 0xEF, 0xF8, 0x09
    msg_len equ $ - encrypted_message

    initial_key equ 0xAA
    secret_seed equ 0x13

section .bss
    decrypted_buffer: resb msg_len

section .text
    global _start

_start:
    mov rsi, encrypted_message
    mov rdi, decrypted_buffer
    mov rcx, msg_len
    mov r8b, initial_key
    mov r9b, secret_seed

decrypt_loop_jsxs:
    cmp rcx, 0
    je  decrypt_done_jsxs

    mov al, byte [rsi]
    xor al, r8b
    mov byte [rdi], al

    add r8b, r9b

    inc rsi
    inc rdi
    dec rcx
    jmp decrypt_loop_jsxs

decrypt_done_jsxs:
    mov rax, 1
    mov rdi, 1
    mov rsi, decrypted_buffer
    mov rdx, msg_len
    dec rdx
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall