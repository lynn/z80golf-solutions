R:push de     ; Push $0000
  call $8003  ; Call getchar()
  jr nc, S    ; Halt on EOF
  halt
S:cp 'o'
  jr c, R   ; Ignore below 'o'
  jr z, O   ; Jump to output code if == 'o'
  inc b     ; Otherwise ('p'), increment the Pluso accumulator
  jr R      ; and start from top.
O:ld a, b   ; Load Pluso accumulator
  cp 26     ; If it's >= 26, wrap to [-1, 25] range
  jr c, T
  sub 27
  ld b, a
T:cp -1     ; Map -1 to space, others to 'A'..'Z'
  jr nz, U
  add 1+' '-'A'
U:add 'A'
            ; Fall through to $8000 = putchar() then return to pushed $0000.
