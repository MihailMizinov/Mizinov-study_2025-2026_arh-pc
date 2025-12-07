%include 'in_out.asm'

SECTION .data
msg_func db "Функция: f(x) = 2x + 15", 0
msg_result db "Результат: ", 0

SECTION .text
GLOBAL _start

_start:
    mov eax, msg_func
    call sprintLF
    pop ecx
    pop edx
    sub ecx, 1
    mov esi, 0

next:
    cmp ecx, 0
    jz _end
    pop eax           ; берем очередное число
    call atoi         ; преобразуем строку в число, результат в eax
    push eax          ; сохраняем x для передачи в func
    call func         ; вызов функции f(x) = 2x + 15
    add esi, eax      ; суммируем результат
    loop next

_end:
    mov eax, msg_result
    call sprint
    mov eax, esi
    call iprintLF
    call quit

; Подпрограмма func:
; Вход: входное значение x в eax
; Выход: результат f(x) = 2*x + 15 в eax
func:
    push ebx          ; сохраняем используемые регистры
    mov ebx, 2
    mul ebx           ; умножаем eax на 2: результат в edx:eax, edx = старшая часть
    add eax, 15       ; eax = 2*x + 15
    pop ebx
    ret
