dosseg
.model small
.stack 100h
.data
    string db 100 dup(?)
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

uppercase PROC
    ; trece litera citita in AL la uppercase prin scaderea cu 32
    SUB AL, 32

    ret
uppercase ENDP

storeLetter PROC
    ; retine rezultatul in string litera cu litera
    MOV string[SI], AL
    ADD SI, 1

    ret
storeLetter ENDP

main PROC
    MOV AX, @data
    MOV DS, AX

    MOV SI, 0

input:
    call inputLetter
    CMP AL, 36 ; daca am citit caracterul '$' inseamna ca sirul este gata
    JE  finish

    call uppercase
    call storeLetter
    JMP input

    ; afisaza string-ul
finish:
    ; pune si caracterul '$'
    call storeLetter
    call new_line

    ; printeaza string-ul
    MOV AH, 9
    LEA DX, string
    INT 21H

    MOV AH, 4Ch
    INT 21h
main ENDP
end main