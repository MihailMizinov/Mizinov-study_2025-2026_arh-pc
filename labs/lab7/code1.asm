%include "in_out.asm"
 
section .data
    a dd 17
    b dd 23  
    c dd 45
 
section .text
global _start
 
_start:
    mov eax, [a]    ; Берем a
    cmp eax, [b]    ; Сравниваем с b
    jle check_c     ; Если a <= b
    mov eax, [b]    ; Иначе берем b
 
check_c:
    cmp eax, [c]    ; Сравниваем с c
    jle print       ; Если текущее <= c
    mov eax, [c]    ; Иначе берем c
 
print:
    call iprintLF   ; Выводим результат с переводом строки
    call quit       ; Завершаем программу
