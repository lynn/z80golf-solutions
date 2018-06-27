begin:
  push de
  call $8003
  jr nc, ok
  halt
ok:
  cp b
  jr nz, notb
  cp 10
  jr z, begin
notb:
  ld b, a
