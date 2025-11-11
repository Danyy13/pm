dosseg
.model small
.stack 100h
.data
    A db 0
    B db 0
    C db 0
    X dw 8
    n1 db "Introduceti primul numar:$"
    n2 db "Introduceti al doilea numar:$"
    n3 db "Introduceti al treilea numar:$"
    result db "Rezultatul este:$"
.code
new_line PROC
    MOV AH, 2
    MOV DL, 10
    INT 21H
    ret
new_line ENDP

main PROC
    MOV AX, @data
    MOV DS, AX

    MOV AH, 4Ch
    INT 21h
main ENDP
end main

; Intrebari
; 1. A,B,C,D
; 2. AX - 16, CL - 8, BH - 8, AL - 8, DX - 16
; 3. D dw 1
; 4. X db ?
; 5. Nu se poate pentru ca nu se pot face operatii direct pe variabile
; 6. SS - Stack Segment -> retine unde este stack pointer-ul ??
; 7. SS - Stack Segment
; 8. ADD, SUB pentru ca au rezultat, MOV NU va pozitiona indicatorii de conditie
; 9. AL - cei mai putin semnficiativi biti ai registrului A -> 8 biti
; 10. DL - pe 8 biti
; 11. PC - Program Counter / IP - Instruction Pointer