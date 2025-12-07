section .bss
buffer resb 16           ; буфер для ввода строки

section .data
msg_input db "Введите число: ", 0
msg_func  db "Функция: f(x) = 2x + 15", 0
msg_result db "Результат: ", 0

section .text
global _start

extern sprintLF
extern sread
extern atoi
extern iprintLF
extern quit

_start:
    ; Выводим сообщение "Введите число: "
    mov eax, msg_input
    call sprintLF

    ; Чтение строки в buffer, не более 15 символов
    mov eax, buffer
    mov ebx, 15
    call sread

    ; Преобразуем строку в число
    mov eax, buffer
    call atoi           ; результат в eax — число x

    ; Сохраняем x
    mov ebx, eax       

    ; Выводим сообщение "Функция: f(x) = 2x + 15"
    mov eax, msg_func
    call sprintLF

    ; Вычисляем f(x) = 2x + 15
    mov eax, ebx
    mov ecx, 2
    mul ecx            ; eax = 2*x (mul ecx: eax = eax*ecx)
    add eax, 15        ; eax = 2x + 15

    ; Выводим сообщение "Результат: "
    mov ebx, eax       ; сохраним результат для вывода

    mov eax, msg_result
    call sprintLF

    ; Выводим результат
    mov eax, ebx
    call iprintLF

    ; Завершаем программу
    call quit
