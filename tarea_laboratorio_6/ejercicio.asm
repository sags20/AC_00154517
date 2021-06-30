	;NOTA: el codigo base es el brindado como ejemplo para el labo 6
	org 	100h

	section	.text

	;Pedir contraseña
	mov 	DX, writePass
	call  	writeString

	;Input contraseña
	mov 	BP, size
	call  	readString

    ;Llamada a las funciones
	call 	writeString
	call	key

	int 	20h

;Textos y datos a usar
	section	.data
writePass db "Password: ", "$"
wPass db "INCORRECTO ", "$"
rPass db "BIENVENIDO ", "$"
size times 5 db	" " 
myPassword db "drako$"

;Funciones
key:
        mov     AH, 01h         
        int     21h
        ret

; Permite escribir en la salida estándar una cadena de caracteres o string, este
; debe tener como terminación el carácter “$”
writeString:
	mov 	AH, 09h
	int 	21h
	ret

; Leer cadena de texto desde el teclado
readString:
        xor SI, SI         
while:  
        call key  
        cmp AL, 0x0D        
        je exit            
        mov [BP+SI], AL   	            
        jmp compareString  

;comparando las contraseñas
compareString:
        xor SI,SI
        mov BH, [SI + size]   
        mov BL, [SI + myPassword]   
        INC SI 
        cmp BH, BL  
		je right 
		jne wrong 
        jmp while

;contraseña incorrecta
wrong:
		xor DX, DX
		mov DX, wPass
		jmp while

;Contraseña correcta
right:       
        xor DX, DX
		mov DX, rPass
		jmp while

exit:
        mov byte [BP+SI], "$"	
        ret


