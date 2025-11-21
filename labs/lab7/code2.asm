%include "in_out.asm"
 
SECTION .data
msg_x: DB 'Введите x: ',0
msg_a: DB 'Введите a: ',0
msg_result: DB 'Результат: ',0
 
SECTION .bss
x: RESB 80
a: RESB 80
 
SECTION .text
GLOBAL _start
 
; Функция f(x)
f_x:
    cmp ebx, ecx        ; Сравниваем x и a
    jge .else_case      ; если x >= a
 
    ; Случай x < a: f(x) = 2a - x
    mov eax, ecx        ; eax = a
    add eax, eax        ; eax = 2a
    sub eax, ebx        ; eax = 2a - x
    ret
 
.else_case:
    ; Случай x >= a: f(x) = 8
    mov eax, 8
    ret
 
_start:
    ; Ввод x
    mov eax, msg_x
    call sprint
 
    mov ecx, x
    mov edx, 80
    call sread
    mov eax, x
    call atoi          ; eax = x
    push eax           ; сохраняем x в стек
 
    ; Ввод a
    mov eax, msg_a
    call sprint
 
    mov ecx, a
    mov edx, 80
    call sread
    mov eax, a
    call atoi          ; eax = a
    mov ecx, eax       ; ecx = a
    pop ebx            ; ebx = x
 
    ; Вызов функции f(x)
    call f_x
 
    ; Вывод результата
    push eax
    mov eax, msg_result
    call sprint
    pop eax
    call iprintLF
 
    call quit
