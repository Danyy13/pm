dosseg
.model small
.stack 100h
.data
    ANTEPREC db 0
    PREC db 1
    CURENT db 0
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

    MOV DL, 0
    CALL outputDigit

    MOV DL, 1
    CALL outputDigit

lp: MOV BH, 0
    ADD BH, ANTEPREC
    ADD BH, PREC
    MOV BL, PREC
    MOV DL, BH
    MOV ANTEPREC, BL
    MOV PREC, DL
    CALL outputDigit
    ADD CL, 1
    CMP CL, 4
    JNE lp

main ENDP
end main