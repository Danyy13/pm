dosseg
.model small
.stack 100h
.data
    a db 0
    b db 0
    cmmdc db 0
    firstNumber db "Introduceti primul numar: $"
    secondNumber db "Introduceti al doilea numar: $"
.code

new_line PROC
    MOV AH, 2
    MOV DL, 10 ; 10 = 0x0A = ASCII pentru LF
    INT 21H
    ret    
new_line ENDP

outputDigit PROC
    MOV AH, 2
    ADD DL, 30h
    INT 21H
    MOV DL, 20h ; spacebar
    INT 21H
    ret
outputDigit ENDP

inputDigit PROC
    MOV AH, 1 ; Pune in AH valoarea pentru a activa serviciul de citire
    INT 21H ; citeste
    SUB AL, 30h ; converteste in cifra
    ; call new_line
    ret
inputDigit ENDP

endProgram PROC
    MOV AH, 4Ch
    INT 21H
endProgram ENDP

main PROC
    MOV AX, @data
    MOV DS, AX

    ; citeste primul numar
    MOV AH, 9
    MOV DX, offset firstNumber ; afisaza string-ul pentru primul
    INT 21H
    call inputDigit ; citeste o cifra si o pune in AL
    MOV a, AL ; iau rezultatul din AL
    call new_line

    ; citeste al doilea numar
    MOV AH, 9
    MOV DX, offset secondNumber
    INT 21H
    call inputDigit
    MOV b, AL
    call new_line

    ; pune valorile in registru pentru a calcula cmmdc mai simplu
    MOV BL, a
    MOV BH, b

lp: CMP BL, BH
    JE ending
    JNS greater
    JS  less
greater:
    SUB BL, BH
    JMP after
less:
    SUB BH, BL
after:
    JMP lp

ending:
    MOV cmmdc, BL ; retin valoarea intr-o variabila
    MOV DL, BL
    call outputDigit
    call new_line

cmmmc:
    MOV AL, a
    MUL b
    DIV cmmdc

    MOV DL, AL ; afisez ce am in AL adica rezultatul impartirii
    call outputDigit

    call endProgram

main ENDP
end main