        org 100h

        section .text

        XOR AX, AX ; Limpiando el registro AX
        MOV AX,0d
        jmp iterar


iterar:
        CMP AX, 23d
        JE Prom
        ADD AX, AX
        ADD AX, 1d
        ADD AX, 5d
        ADD AX, 4d
        ADD AX, 5d
        ADD AX, 1d
        ADD AX, 7d
        jmp iterar

Prom:
        CMP AX, 3d
        JBE exit
        MOV BX,8d
        DIV BX
        MOV [20Ah],AX

exit:
        int 20h