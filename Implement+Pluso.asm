R:push de
  call $8003
  jr nc, S
  halt
S:cp 'o'
  jr c, R
  jr z, T
  inc b
  jr R
T:ld a, b
  cp 26
  jr c, U
  sub 27
  ld b, a
U:cp -1
  jr nz, V
  add 1-'A'+' '
V:add 'A'
