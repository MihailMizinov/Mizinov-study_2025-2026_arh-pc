%include 'in_out.asm'

SECTION .data
    filename db 'name.txt', 0
    prompt db 'What is your name? ', 0
    message db 'My name is '
    newline db 0xA
    success_msg db 'File created successfully!', 0xA, 0

SECTION .bss
    contents resb 256

SECTION .text
global _start

_start:
    ; Print prompt
    mov eax, prompt
    call sprint

    ; Read name
    mov eax, 3
    mov ebx, 0
    mov ecx, contents
    mov edx, 255
    int 0x80
    
    ; Remove newline
    dec eax
    mov byte [contents + eax], 0

    ; Create/open file for writing (truncate if exists)
    mov eax, 5          ; open
    mov ebx, filename
    mov ecx, 0101o      ; O_CREAT|O_WRONLY (creates new file)
    mov edx, 0644o      ; permissions
    int 0x80
    
    ; eax now has file descriptor
    mov ebx, eax        ; save fd in ebx

    ; Write "My name is " (11 bytes)
    mov ecx, message
    mov edx, 11
    mov eax, 4          ; write
    int 0x80

    ; Write the name
    ; First get name length
    mov edi, contents
    xor ecx, ecx
get_len:
    cmp byte [edi + ecx], 0
    je len_done
    inc ecx
    jmp get_len
len_done:
    mov edx, ecx        ; length
    mov ecx, contents   ; buffer
    mov eax, 4          ; write
    int 0x80

    ; Write newline
    mov ecx, newline
    mov edx, 1
    mov eax, 4
    int 0x80

    ; Close file
    mov eax, 6          ; close
    int 0x80

    ; Success
    mov eax, success_msg
    call sprint

    ; Exit
    mov eax, 1
    xor ebx, ebx
    int 0x80
