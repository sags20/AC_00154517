        org 100h
        section .text

        ;mov CL, "S"
        mov byte [200h], "S"
        ;mov CL, "A"
        mov byte [201h], "A"
        ;mov CL, "G"
        mov byte [202h], "G"
        ;mov CL, "S"
        mov byte [203h], "S"


        mov BX, 200h
        mov SI, 0002h

        
;direccionamiento directo absoluto AX
        mov AX, DS:[200h]

;direccionamiento por registro CX
        mov CX,[BX]

;direccionamiento indirecto base + indice DX
        mov DX,[BX+SI]

;direccionamiento relativo por registro DI
        mov DI, DS:[BX+0003h]



        int 20h