  ld b,48   ; line counter
  ld c,'!'  ; center char

line:
  ; Print L-1 spaces.
  ld a,' '
  ld e,b
spaces:
  dec e
  jr z, pylon
  rst $38
  jr spaces

  ; Print characters from D=80-L to B and back.
pylon:
  ld a,80
  sub b
  ld d,a
left:
  rst $38
  inc a
  cp c
  jr nz, left

  inc c
  inc c
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

  djnz line
  halt

