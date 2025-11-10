dosseg
.model small
.stack 100h
.data
    A db 0
    B db 0
    C db 0
    D db 0
    n1 db "Introduceti primul numar:$"
    n2 db "Introduceti al doilea numar:$"
    n3 db "Introduceti al treilea numar:$"
    n4 db "Introduceti al patrulea numar:$"
    result db "Rezultatul este:$"
.code
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
    MOV AH, 1 ; Pune in AH valoarea pentru a activa serviciul de citire
    INT 21H ; citeste
    SUB AL, 30h ; converteste in cifra
    MOV A, AL
    CALL new_line
    ; citirea celui de-al doilea numar
    MOV AH, 9
    MOV DX, offset n2
    INT 21H
    MOV AH, 1
    INT 21H
    SUB AL, 30h
    MOV B, AL
    CALL new_line
    ; citirea celui de-al treilea numar
    MOV AH, 9
    MOV DX, offset n3
    INT 21H
    MOV AH, 1
    INT 21H
    SUB AL, 30h
    MOV C, AL
    CALL new_line
    ; citirea celui de-al patrulea numar
    MOV AH, 9
    MOV DX, offset n4
    INT 21H
    MOV AH, 1
    INT 21H
    SUB AL, 30h
    MOV D, AL
    CALL new_line
    ; afisaza "Rezultatul este:"
    MOV AH, 9
    MOV DX, offset result
    INT 21H
    ; calc suma A + B
    MOV AL, A
    SUB AL, B
    ; adaug C in rezultat
    ADD AL, C
    ; scad D
    SUB AL, D
    ; converteste inapoi in ascii
    ADD AL, 30h
    ; afisaza rezultatul
    MOV AH, 2 ; serviciu de afisare
    MOV DL, AL ; rezultatul este copiat in registrul DL
    INT 21H
    MOV AH, 4Ch
    INT 21H
main ENDP
end main

; A - B + C - D