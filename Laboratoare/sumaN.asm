dosseg
.model small
.stack 100h
.data
    n db 3
.code
outputDigit PROC
    MOV AH, 2
    ADD AL, 30h
    MOV DL, AL
    INT 21H
    MOV DL, 20h ; spacebar
    INT 21H
    ret
outputDigit ENDP
main PROC
    MOV AX, @data
    MOV DS, AX

    MOV CL, 1
    

main ENDP
end main