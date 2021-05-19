format PE CONSOLE 4.0
entry start
include 'win32a.inc'
section '.data' data readable writeable 

        hHandle dd 0
        hConI db "Handle hStdin"
        cc_1 db "%s",13,10,"%s",13,10,"%s",13,10,0
        cc_0 db "Hola",0
        cc_2 db "Mundo", 0
        cc_3 db "2021", 0
        cc_4 db "%d", 0
        cc_5 db "%s", 0
        cc_char db "%c", 0
        cc_6 db "Age inputted: %d", 0
        cc_7 db "Name inputted: %s", 0
        cc_8 db "Char inputted: %s", 0
        f db "calc.exe",0
        fd db "C:\Windows\System32\",0
        namem dt ?
        age dw ?
        char db ?


section '.code' code readable executable

start:
        ;push namem
        ;push cc_5
        ;call [scanf]
        ;add esp, 8
        ;push namem
        ;push cc_7
        ;call [printf]
        ;add esp, 8
        ;call [getchar]
        push age
        push cc_4
        call [scanf]
        add esp, 8
        push age
        push cc_6
        call [printf]
        add esp, 8
        call [getchar]
       ; push char
       ; push cc_char
       ; call [scanf]
       ; add esp, 8
       ; push char
       ; push cc_8
       ; call [printf]
       ; add esp, 8
       ; call [getchar]

        push SW_SHOWNORMAL
        push fd
        push 0
        push f
        push 0
        push hHandle
        call [shellexecute]

        call[getchar]

        push 0
        call [ExitProcess]


section '.idata' import data readable writeable 

library kernel,'KERNEL32.DLL',\ 
        msvcrt,'MSVCRT.DLL',\
        shell, 'SHELL32'
import kernel,\
        ExitProcess,'ExitProcess',\
        SleepEx,'SleepEx',\
        GetStdHandle,'GetStdHandle'
import msvcrt,\ 
        printf,'printf',\
        getchar, 'getchar',\
        scanf, 'scanf',\
        getint, 'getint',\
        putchar, 'putchar'
import shell,\
        shellexecute,'ShellExecuteA',\
        readconsoleinput, 'ReadConsoleInput'