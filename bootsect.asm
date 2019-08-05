segment bootsect byte public 'CODE'
assume cs:bootsect, ds:bootsect
org 7c00h           ; boot loader will start at 0000:7c00h
proc main
    cli             ; init segments at 0000h
    xor ax, ax
    mov ds, ax
    mov ss, ax
    mov sp, 7c00h   ; init stack just below boot loader
    sti

    lea si, message
@@1:
    lodsb           ; load character
    or al, al
    jz short @@2    ; end of message

    mov ah, 0eh     ; print character (tty mode)
    mov bx, 7h
    int 10h

    jmp short @@1

@@2:
    jmp short $     ; infinite loop

message:
    db 'Hello World!', 0h

org 7dfeh           ; 7c00h + 512 bytes per sector - 2 bytes for magic number
    dw 0aa55h       ; magic number at end of boot sector
endp main
ends bootsect
end main
