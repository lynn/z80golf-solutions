  push de
  call $8003
  jr nc, ok
  halt
ok:
  xor 32
