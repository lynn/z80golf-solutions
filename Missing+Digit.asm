  push de
nextline:
  ld b, '0'^'1'^'2'^'3'^'4'^'5'^'6'^'7'^'8'^'9'
nextchar:
  call $8003
  jr nc, ok
  halt
ok:
  cp '\n'
  jr z, endline
  xor b
  ld b, a
  jr nextchar
endline:
  ld a, b
  rst $38
  ld a, '\n'
