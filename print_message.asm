print_message:
  pusha
  mov ah, 0x0e
  call print_loop 
  popa 
  ret 

print_loop:
  mov al, [bx]
  int 0x10
  add bx, 1
  cmp al, 0 
  jne print_loop
  ret
 
print_new_line:
  mov ah, 0x0e 
  mov al, 0x0d
  int 0x10 
  mov al, 0x0a
  int 0x10
  ret



; if the value of the byte is between 0 <= b <= 9 adds 0x30
; if its between 10 <= b <= 15 add 0x30
; to represent ascii

print_hex:
  pusha
  mov bx, dx
  and bx, 0xf000
  shr bx, 12

  call convert 
  mov [HEX_OUT + 2], bx


  mov bx, dx
  and bx, 0x0f00
  shr bx, 8
  call convert 
  mov [HEX_OUT + 3], bx


  mov bx, dx
  and bx, 0x00f0
  shr bx, 4
  call convert 

  mov [HEX_OUT + 4], bx

  mov bx, dx
  and bx, 0x000f
  call convert 
  mov [HEX_OUT + 5], bx

  mov bx, HEX_OUT
  call print_message
  call print_new_line
  popa
  ret 

convert:
  mov cx, bx
  add bx, 0x30
  cmp cx, 10
  jge convert_char  
  ret 

convert_char:
  sub bx, 0x30
  add bx, 0x37
  ret


HEX_OUT: db '0x0000', 0