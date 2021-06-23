org 100h

    section .text
    ;Limpiando el registro AX
    XOR AX, AX
    XOR BX, BX
    XOR CL, CL
    XOR CX, CX
    XOR DX, DX
    XOR SI, SI
    
    ;Indices a usar
    MOV SI, 0
    MOV DI, 0d
    
    ;Fila y columana para mostrar el cursor
    MOV DH, 10
    MOV DL, 15

    ;LLamando a la funcion que activa el modo texto para mostar en pantalla 
    call textMode
    
    ;Funciones a usar para recorrer los nombres y apellidos
    ;Para pasar a la siguiente fila se hizo uso de la memoria empezando en 200h y terminando en 203h 
    
    firstName:
    ;Primer nombre en el espacio de memoria 200h y la fila 10
    MOV byte[200h],10
    ;Se pasa el dato guardado en 200h a DH
    MOV DH, [200h]
    ;Se llama a la funcion que escribira en pantalla la cadena
    call writeCharacter
    ;Se compara el indice con el tamaño del nombre, se le suma 1 al tamaño del nombre para asegurarse que se escribira completo
    CMP SI, 6
    ;Se usa la comparacion JB para que el programa continue su ejecucion solo cuando ya se a recorrido TODO el nombre 
    ;que se esta mostrando 
    JB firstName
    ;Se usa para aseguarase que al cambiar de fila empezara en la columna que queremos y el indice vuelva a 0, asi pueda tomar
    ;el tamaño del siguiente nombre
    ;Se empieza en la columna 15
    MOV DL,15
    ;Indice a 0
    MOV SI,0
    ;Salta a recorrer el siguiente nombre
    jmp secondName

    secondName:
    ;Se repite el proceso anterior solo que con el espacio de memoria 201h y la fila 11
    MOV byte[201h],11
    MOV DH, [201h]
    call writeCharacter
    CMP SI,10
    JB secondName
    MOV DL,15
    MOV SI,0
    jmp firstLastname

    firstLastname:
    ;Se repite el proceso anterior solo que con el espacio de memoria 202h y la fila 12
    MOV byte[202h],12
    MOV DH, [202h]
    call writeCharacter
    CMP SI, 7
    JB firstLastname
    MOV DL,15
    MOV SI,0
    jmp secondLastname

    secondLastname:
    ;Se repite el proceso anterior solo que con el espacio de memoria 203h y la fila 13
    MOV byte[203h],13
    MOV DH, [203h]
    call writeCharacter
    CMP SI, 9
    JB secondLastname
    ;Ya que se llego al ultimo apellido se llama a la funcion keyExit la cual espera que se precione una tecla 
    ;para para pasar a la siguiente instruccion y luego termina
    call keyExit

    ;Funcion que ayuda a mover el cursor
    cursor:
    ;Se selecciona el numero de pagina en el que se posicionara el cursor
    MOV BH, 0h
    ;Posiciona el cursor en pantalla
    MOV AH, 02h
    INT 10h
    RET

    writeCharacter:
    ;Se llama a la funcion cursor
    call cursor
    ;Para escribir la cadena en pantalla se guarda la cadena en el registro CL
    MOV CL,[cadena+DI]
    ;Escribe los caracteres segun la posicion del cursor
    MOV AH, 0Ah
    ;Se identifica los caracteres a mostrar en pantalla
    MOV AL,CL
    ;Numero de pagina en el que se escribira
    MOV BH,0h
    ;# de veces que se repetira un caracter 
    MOV CX ,1h
    ;Se incrementan los indices hasta llegar al ultimo caracter
    INC DI
    INC DL
    INC SI
    INT 10h
    RET

    ;Funcion para activar el modo texto
    textMode:
    ;Activa modo texto
    MOV AH, 00h
    ;Se selecciona el modo grafico a utilizar
    MOV AL, 03h
    INT 10h
    RET

    ;Funcion para la tecla y el final del codigo
    keyExit:
    ;Espera que se precione una tecla para para pasar a la siguiente instruccion 
    MOV AH, 00h 
    INT 16h
    ;Termina el programa
    int 20h

    section .data
    ;Txto a mostrar 
    cadena DB 'Sofia Alexandra Galvez Salguero'