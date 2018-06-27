next:
  ld a, ':'
  rst $38
  inc l
  dec l
  jr z, endl
  ld a, '-'
  rst $38
smile:
  dec b
  jr z, endl
  jp m, endl
  ld a, ')'
  rst $38
  jr nz, smile
endl:
  ld b, l
  inc l
  inc l
  ld a, '\n'
  rst $38
  ld a, 68
  cp l
  jr nz, next
  halt
