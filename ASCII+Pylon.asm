  ld l,48   ; line counter
  ld b,'!'  ; center char

line:
  ; Print L-1 spaces.
  ld a,' '
  ld e,l
spaces:
  dec e
  jr z, pylon
  rst $38
  jr spaces

  ; Print characters from D=80-L to B and back.
pylon:
  ld a,80
  sub l
  ld d,a
left:
  rst $38
  inc a
  cp b
  jr nz, left

  inc b
  inc b
  dec a

right:
  cp d
  jr z, endline
  dec a
  rst $38
  jr right

  ; Done. Loop until L is 0.
endline:
  ld a,'\n'
  rst $38

  dec l
  jr nz, line
  halt

