dosseg
.model small
.stack 100h
.data
    ANTEPREC db 0
    PREC db 1
    CURENT db 0
    a db 9
    b db 6
.code
outputDigit PROC
    MOV AH, 2
    ADD DL, 30h
    INT 21H
    MOV DL, 20h ; spacebar
    INT 21H
    ret
outputDigit ENDP
main PROC
    MOV AX, @data
    MOV DS, AX

    MOV BL, a
    MOV BH, b

lp: CMP BL, BH
    JE ending
    CMP BL, BH
    JNS greater
    CMP BL, BH
    JS  less
greater:
    SUB BL, BH
    JMP after
less:
    SUB BH, BL
after:
    JMP lp

ending:
    MOV DL, BL
    call outputDigit

main ENDP
end main