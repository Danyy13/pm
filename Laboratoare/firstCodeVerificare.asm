dosseg
.model small
.stack 100h
.data
    NUMBER db 0
    A db 0
    B db 0
    C db 0
    D db 0
    DIGIT_ZERO db 30h
    DIGIT_NINE db 39h
    n1 db "Introduceti primul numar:$"
    n2 db "Introduceti al doilea numar:$"
    n3 db "Introduceti al treilea numar:$"
    n4 db "Introduceti al patrulea numar:$"
    result db "Rezultatul este:$"
    reinsert db "Reintroduceti numarul:$"
.code

outputDigit PROC
    MOV AH, 2
    ADD DL, 30h
    INT 21H
    MOV DL, 20h ; spacebar
    INT 21H
    ret
outputDigit ENDP

readChar PROC
s:  MOV AH, 1 ; Pune in AH valoarea pentru a activa serviciul de citire ; start functie
    INT 21H ; citeste
    CMP AL, DIGIT_ZERO
    JL ri
    CMP AL, DIGIT_NINE
    JG ri
    SUB AL, DIGIT_ZERO ; converteste in cifra
    ; MOV NUMBER, AL
    CALL new_line
    JMP e
ri: CALl new_line
    MOV AH, 9 ; ri = reinsert
    MOV DX, offset reinsert
    INT 21H
    JMP s
e:  ret ; e = end
readChar ENDP

new_line PROC
    MOV AH, 2
    MOV DL, 10 ; 10 = 0x0A = ASCII pentru LF
    INT 21H
    ret    
new_line ENDP
main PROC
    MOV AX, @data
    MOV DS, AX
    ; citirea primului numar
    MOV AH, 9
    MOV DX, offset n1 ; afisaza string "Introduceti"
    INT 21H
    CALL readChar
    MOV A, AL
    
    MOV DL, A
    CALL outputDigit

    ; ; afisaza "Rezultatul este:"
    ; MOV AH, 9
    ; MOV DX, offset result
    ; INT 21H
    ; ; calc suma A + B
    ; MOV AL, A
    ; SUB AL, B
    ; ; adaug C in rezultat
    ; ADD AL, C
    ; ; scad D
    ; SUB AL, D
    ; ; converteste inapoi in ascii
    ; ADD AL, DIGIT_ZERO
    ; ; afisaza rezultatul
    ; MOV AH, 2 ; serviciu de afisare
    ; MOV DL, AL ; rezultatul este copiat in registrul DL
    ; INT 21H
    MOV AH, 4Ch
    INT 21H
main ENDP
end main

; dupa afisare nu ne bazam pe accumulator
; putem salva toti registrii pe stiva
; sau intr-o variabila