dosseg
.model small
.stack 100h
.data
    string db 50 dup(?)
    newString db 50 dup(?)
    vocale db 'a', 'e', 'i', 'o', 'u'
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

storeLetterToString PROC
    ; retine rezultatul in string litera cu litera
    MOV string[SI], AL
    ADD SI, 1

    ret
storeLetterToString ENDP

main PROC
    MOV AX, @data
    MOV DS, AX

    MOV SI, 0

    ; input string
input:
    call inputLetter
    call storeLetterToString
    CMP AL, '$'
    JE  endInput
    JMP input

endInput:
    call new_line
    ; initializam indecsii
    MOV SI, 0
    MOV DI, 0

    ; parcurg string-ul si verific daca litera se gaseste in array-ul "vocale" declarat (for in for)
getLetter:
    ; preia litera din string
    MOV AL, string[SI]
    ADD SI, 1

    ; daca litera este '$' gata
    CMP AL, '$'
    MOV newString[DI], AL
    JE  finish

    MOV BX, 0
compareToVowel:
    CMP AL, vocale[BX]
    JE  addLetterToNewString
    
    ADD BX, 1
    CMP BX, 5 ; exista doar 5 vocale
    JE  getLetter
    
    JMP compareToVowel

addLetterToNewString:
    MOV newString[DI], AL
    ADD DI, 1
    JMP getLetter

finish:
    ; afisez string-ul nou creat
    MOV AH, 9
    LEA DX, newString
    INT 21H

    MOV AH, 4Ch
    INT 21h
main ENDP
end main