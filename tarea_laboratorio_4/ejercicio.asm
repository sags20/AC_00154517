        org  100h

        section .text
        ;Puntero del arreglo
        MOV BP, arrNum

        ;Registros a usar inicializados en 0 
        XOR SI,SI 
        XOR CX,CX
        XOR DI,DI
        XOR DX,DX

        ;Llamada a la función 
        CALL OddEven

        int 20h

        section .data
;Arreglo de 10 numeron de 1 byte 
arrNum DB 3,2,9,8,5,7,1,4,6,3 ;10 numeros de 1 al 9

;Para encontrar los numeros pares se dividen entre 2, se define la constante 
;NOTA: ambas formas daban el error "ejercicio.asm:25: error: comma, colon, decorator or end of line expected after operand"
;por lo que se decidio usar el registro MOV BL,02d para la division 
;div equ 2
;div DB 2

;Función general(contiene el recorrido del arreglo, y las comprobaciones de par e impar)
OddEven:
        ;Para saber que es par se divide el numero entre 2 
        MOV BL, 02d

;funcion de recorrido
R:
        ;Si el SI es igual a 10 (total de numero en el arreglo), entonces termina el proceso y salta a End 
        CMP SI, 10
        JE End
        ;Se limpia AH para no tener problemas en el resultado de la division
        XOR AH,AH
        ;Se mueve el la posicion actual al registro AL
        MOV AL,[BP+SI]
        ;Se copia el dato de AL en BH para no perderlo y se realiza la division
        MOV BH,AL
        DIV BL
        ;Se incrementa el valor de SI
        INC SI
        ;Se compara el residuo de la division
        ;Si el residio (AH) es 0 salta a Even y si es distinto de 0 salta a Odd
        CMP AH,0
        JE Even
        JNE Odd

;Etiqueta para proceso de numeros pares
Even:
        ;CX= 0
        ;Se le asigana CX(0) a DI, DI será el nuevo indice 
        MOV DI,CX
        ;Se mueve el valor que se copio en BH a la drieccion de memoria, en este caso 0300H
        MOV[300h+DI], BH
        ;Se incremente el DI 
        INC DI 
        ;Se mueve el valor de DI ya incrementado a CX, esto hara que el valor par se coloque en el siguiente 
        ;espacio de memoria es decir 0301H y asi suesivamente con cadanumero par del arreglo
        MOV CX,DI
        ;Luego de comprobar que es par y colocarlo en la memoria se hace un salto a R para comprobar los siguientes numeros
        JMP R

;Etiqueta para procesos de numeros impares
Odd:
        ;Se repite el mismo proceso que con los numeros pares
        ;Se mueve el valor que se copio en BH a la drieccion de memoria, en este caso 0320H
        ;Para los impares se utilizara el registro DX en lugar de CX para que se pueda poner de corrido los 
        ;datos en la direccion de memoria (320,321...) y no dejando espacio lo cual hubiera ocurrido si usaramos CX aqui tambien
        MOV DI,DX
        MOV[320h+DI], BH
        INC DI 
        MOV DX,DI
        JMP R

;Finalización de la llamada 
End:
        RET