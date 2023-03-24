ingresarBin macro suma, numbina


  ingresar:
  mov ah,01h
  int 21h


  cmp al, 31h ;Compara si el ingresado es un 1
  je uno


  cmp al, 30H ;Compara a 0
  jg Error  
  jmp division ;128/2 para: 64, 32, etc.  


  Uno:
  mov al, suma
  add al, numbina
  mov suma, al


  division:
  mov al, numbina
  mov bl, 02h  


  XOR ah,ah
  div bl ;Dividimos bl(2) con al(numbin) AH=residuo AL=Cociente
  mov numbina, al
  loop ingresar


  jmp Imprimir


ENDM




.MODEL SMALL
.STACK
.DATA
   m1 db 10,13,"Ingrese valor en binario: $"
   m2 db 10,13,"El valor es: $"
   m3 db 10,13,"Valor erroneo, ingrese el valor nuevamente",10,13,"$"
   m4 db 10,13,"0. Salir   1. Ingresar otro valor",10,13,"$"
   m5 db 10,13,"Valor no valido",10,13,"$"
   
   numbin db ?
   sum db ?
   
.CODE


  mov ax, @DATA
  mov ds, ax ;Iniciar variables


inicio:


mov ah, 09h
lea dx, m1
int 21h


  mov cl, 08h
  mov numbin, 128
  mov sum, 0


  ingresarBin sum, numbin
 
Error:
mov ah, 09h
lea dx, m3
int 21h


  jmp inicio


Imprimir:
    mov ah, 09h
    lea dx, m2
    int 21h


    ;Convertir el binario a caracter:
  mov ah, 02h
  mov dl, sum
  int 21H
  ;------------imprime lo que tiene suma, que es el caracter


Continuar:
  mov ah, 09h
  lea dx, m4
  int 21h


  mov ah, 01H
  int 21H


  cmp al,30h ;Compara si al tiene 0
  je Salir ;si no: salte


  cmp al, 31h ;Comparas si es un 1
  jne Novalido ;Si es no es 1, entonces regresate a inicio pa
  call inicio


Novalido:
  mov ah, 09h
  lea dx, m5
  int 21h


  jmp Continuar


Salir:
  int 27h


END
