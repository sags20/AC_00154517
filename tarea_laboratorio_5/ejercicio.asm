org 100h

    section .text
    xor AX, AX
    xor SI, SI
    xor BX, BX
    XOR CX, CX
    xor DX, DX

    MOV SI, 0
    MOV DI, 0d
    
    ;Fila y columana para mostrar el cursor
    MOV DH, 10 
    MOV DL, 20d

    call modotexto

;Iteracion principal
    iterar:
    ;Mover el cursor y el caracter a imprimir en pantalla
        call movercursor 
        ;Colocar en CL el caracter actual 
        MOV CL, [cadena+SI] 
        call escribircaracter
        INC SI 
        INC DL
        ;Contador para terminar la ejecución del programa 
        INC DI 
        CMP DI, 35d 
        ;Si DI es menor a 35, entonces que siga iterando. 
        JB iterar
        ;Caso contrario, que salte a esperar tecla.
        jmp tecla

    modotexto: 
        ;Activa modo texto
        MOV AH, 0h 
        ;Modo gráfico deseado
        MOV AL, 03h 
        INT 10h
        RET

    movercursor:
        ;Posiciona el cursor en pantalla.
        MOV AH, 02h 
        MOV BH, 0h

        ;Primer nombre/apellido
        CMP DI, 06d
        JE aumentarFila
        ;Segundo nombre/apellido
        CMP DI, 17d
        JE aumentarFila
        
        INT 10h
        RET

    escribircaracter:
        ;Escribe caracter en pantalla según posición del cursor
        MOV AH, 0Ah 
        MOV AL, CL 
        MOV BH, 0h 
        ;Número de veces a escribir el caracter
        MOV CX, 1h 
        INT 10h
        RET

    ;Funcion que ayuda para recorrer cada nombre y apellido
    aumentarFila :
        INC DH
        MOV DL, 21
        RET

    tecla:
        ;Espera buffer del teclado para avanzar en la siguiente instrucción
        MOV AH, 00h 
        INT 16h

    ;Final del programa 
    exit:
        int 20h

    section .data
    ;Txto a mostrar 
    cadena DB 'Sofia  Alexandra  Galvez  Salguero'