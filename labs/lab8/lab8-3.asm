%include 'in_out.asm'
SECTION .data
msg db "Результат: ",0

SECTION .text
global _start

_start:
pop ecx 
pop edx 
sub ecx,1 
mov esi, 1 

next:
cmp ecx,0h ; проверяем, есть ли еще аргументы
jz _end ; если аргументов нет выходим из цикла
; (переход на метку `_end`)
pop eax ; иначе извлекаем следующий аргумент из стека
call atoi ; преобразуем символ в число
mul esi
mov esi,eax 
; след. аргумент `esi=esi*eax`
loop next ; переход к обработке следующего аргумента


_end:
mov eax, msg ; вывод сообщения "Результат: "
call sprint
mov eax, esi ; записываем сумму в регистр `eax`
call iprintLF ; печать результата
call quit ; завершение программы
