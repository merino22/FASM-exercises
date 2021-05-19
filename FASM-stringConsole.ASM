format PE CONSOLE 4.0
entry start
include 'win32a.inc'
section '.data' data readable writeable 

        n1 db 100 dup 0
        n2 dd ?
        suma dd ?

        f2 db "%s",0
        m1 db "Ingrese su nombre: ",0
        mstr db "%s", 0
        m2 db "El nombre es %s ... ",0

section '.code' code readable executable

start:

        push m1
        call [printf]
        add esp, 4

        push n1
        push f2
        call [scanf]
        add esp, 8

        push n1
        push m2
        call [printf]
        add esp, 8

        ;hacer pausa 2 segundos
        push 0
        push 2000
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
        scanf, 'scanf'