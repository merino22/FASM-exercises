format PE CONSOLE 4.0
entry start
include 'win32a.inc'
section '.data' data readable writeable 

        n1 dd ?
        n2 dd ?
        suma dd ?

        f2 db "%d",0
        m1 db "Ingrese primer numero: ",0
        m3 db "Ingrese segundo numero: ",0
        m5 db "El resultado de la suma es %d", 0

section '.code' code readable executable

start:

        push m1
        call [printf]
        add esp, 4

        push n1
        push f2
        call [scanf]
        add esp, 8

        push m3
        call [printf]
        add esp, 4

        push n2
        push f2
        call [scanf]
        add esp, 8

        mov eax, [n1]
        mov ebx, [n2]

        add eax, ebx
        push eax
        push m5
        call [printf]
        add esp, 8

        ;hacer pausa 5 segundos
        push 0
        push 5000
        call [SleepEx]

        push 0
        call [ExitProcess]


section '.idata' import data readable writeable 

library kernel,'KERNEL32.DLL',\ 
        msvcrt,'MSVCRT.DLL'
import kernel,\
        ExitProcess,'ExitProcess',\
        SleepEx,'SleepEx'
import msvcrt,\
        printf,'printf',\
        scanf, 'scanf',\
        getchar, 'getchar'