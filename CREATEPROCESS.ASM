format PE CONSOLE 4.0
entry start
include 'win32a.inc'

struc PROCESS_INFORMATION hProcess, hThread,dwProcessId, dwThreadId {
      .hProcess dd hProcess
      .hThread dd hThread
      .dwProcessId db dwProcessId
      .dwThreadId db dwThreadId
}

struc STARTUPINFOA cb, lpReserved, lpDesktop, lpTitle, dwX, dwY, dwXSize, dwYSize, dwXCountChars, dwYCountChars, dwFillAttribute, dwFlags, wShowWindow, cbReserved2, lpReserved2, hStdInput, hStdOutput, hStdError {
    .cb dd cb
    .lpReserved db lpReserved
    .lpDesktop db lpDesktop
    .lpTitle db lpTitle
    .dwX dd dwX
    .dwY dd dwY
    .dwXSize dd dwXSize
    .dwYSize dd dwYSize
    .dwXCountChars dd dwXCountChars
    .dwYCountChars dd dwYCountChars
    .dwFillAttribute db dwFillAttribute
    .dwFlags dd dwFlags
    .wShowWindow db wShowWindow
    .cbReserved2 dd cbReserved2
    .lpReserved2 dd lpReserved2
    .hStdInput db hStdInput
    .hStdOutput db hStdOutput
    .hStdError db hStdError
}

startupinfo STARTUPINFOA 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x00000004, 0, 0, 0, 0, 0, 0

proInfo PROCESS_INFORMATION 0, 0, "1", "1"
proInfo2 PROCESS_INFORMATION 0, 0, "2", "2"

section '.data' data readable writeable

        f db "FASM-ConsoleUsage.exe",0
        fd db "FASM-stringConsole.exe",0


section '.code' code readable executable

start:

        push proInfo     ;lpProcessInformation
        push startupinfo ;lpStartupInfo
        push 0           ;lpCurrentDirectory
        push 0           ;lpEnvironment
        push 0x00000010  ;dwCreationFlags
        push 0           ;bInheritHandles
        push 0           ;lpTHreadAttribute
        push 0           ;lpProcessAttribute
        push 0           ;lpCommandLine
        push f           ;lpApplicationName
        call [CreateProcessA]

        push 3000
        push [proInfo.hProcess]
        call [WaitForSingleObject]

        push [proInfo.hProcess]
        call [CloseHandle]
        push [proInfo.hThread]
        call [CloseHandle]

        push proInfo2
        push startupinfo
        push 0
        push 0
        push 0x00000010
        push 0
        push 0
        push 0
        push 0
        push fd
        call [CreateProcessA]

        push 0
        call [ExitProcess]


section '.idata' import data readable writeable 

library kernel,'KERNEL32.DLL',\ 
        msvcrt,'MSVCRT.DLL',\
        shell, 'SHELL32'
import kernel,\
        ExitProcess,'ExitProcess',\
        SleepEx,'SleepEx',\
        GetStdHandle,'GetStdHandle',\
        CreateProcessA, 'CreateProcessA',\
        WaitForSingleObject, 'WaitForSingleObject',\
        CloseHandle, 'CloseHandle'
import msvcrt,\ 
        printf,'printf',\
        getchar, 'getchar',\
        scanf, 'scanf',\
        getint, 'getint',\
        putchar, 'putchar'
import shell,\
        shellexecute,'ShellExecuteA',\
        readconsoleinput, 'ReadConsoleInput'