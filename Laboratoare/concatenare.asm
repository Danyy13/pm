dosseg
.model small
.stack 100h
.data
    msg1 db 50 dup(?)
    msg2 db 50 dup(?)
    msgConcat db 100 dup(?)
.code
new_line PROC
    MOV AH, 2
    MOV DL, 10
    INT 21H
    ret
new_line ENDP

inputLetter PROC
    ; citeste o litera si o retine in AL
    MOV AH, 1
    INT 21H ; se citeste litera mica in registrul AL

    ret
inputLetter ENDP

storeLetterToMsg1 PROC
    ; retine rezultatul in string litera cu litera
    MOV msg1[SI], AL
    ADD SI, 1

    ret
storeLetterToMsg1 ENDP

storeLetterToMsg2 PROC
    MOV msg2[SI], AL
    ADD SI, 1

    ret
storeLetterToMsg2 ENDP

main PROC
    MOV AX, @data
    MOV DS, AX

    MOV SI, 0 ; neaparat sa punem index-ul pe 0 la fiecare sir nou citit
inputMsg1:
    call inputLetter
    call storeLetterToMsg1
    CMP AL, 36 ; daca am citit caracterul '$' inseamna ca sirul este gata
    JE  finishMsg1
    JMP inputMsg1

finishMsg1:
    call new_line
    MOV SI, 0 ; neaparat sa punem index-ul pe 0 la fiecare sir nou citit
inputMsg2:
    call inputLetter
    call storeLetterToMsg2
    CMP AL, 36 ; daca am citit caracterul '$' inseamna ca sirul este gata
    JE  finishMsg2
    JMP inputMsg2

finishMsg2:
    call new_line
    MOV SI, 0
    MOV DI, 0
buildStringPart1:
    MOV AL, msg1[DI]
    CMP AL, '$'
    JE finishBuildStringPart1

    MOV msgConcat[SI], AL
    ADD DI, 1
    ADD SI, 1
    JMP buildStringPart1

finishBuildStringPart1:
    MOV DI, 0 ; punem DI pe 0, va fi counter-ul pentru string-ul al doilea
buildStringPart2:
    MOV AL, msg2[DI]
    MOV msgConcat[SI], AL
    CMP AL, '$'
    JE finishBuildStringPart2

    ADD DI, 1
    ADD SI, 1
    JMP buildStringPart2

finishBuildStringPart2:
    ; afisare
    MOV AH, 9
    LEA DX, msgConcat
    INT 21H

    MOV AH, 4Ch
    INT 21h
main ENDP
end main