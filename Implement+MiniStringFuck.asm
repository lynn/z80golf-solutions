R:push de
  call $8003
  jp c, S+1      ; jump to HALT
  cp '.'
  ld a,b
S:jr z, $+2+$76  ; offset = HALT opcode
  inc b
  jr R
