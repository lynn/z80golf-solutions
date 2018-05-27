  push de
  call $8003
  jr nc, ok
  halt
ok:
  cp ')'
  jr z, right_paren
  jr nc, digit
  inc c
  inc c
right_paren:
  dec c 
  sub c
digit:
  add c
