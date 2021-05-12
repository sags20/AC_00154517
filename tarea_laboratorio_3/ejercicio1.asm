        org 100h

        section .text

        XOR AX, AX ; Limpiando el registro AX
        MOV AX,0d
        jmp iterar


iterar:
        CMP AX, 23d
        JE exit
        ADD AX,AX
        ADD AX, 1d
        ADD AX, 5d
        ADD AX, 4d
        ADD AX, 5d
        ADD AX, 1d
        ADD AX, 7d
        jmp iterar
        

exit:
        int 20h