  inc h       ; Point HL at arr = 0x0100
  ld c, 18    ; Repeat for C=18..0:
read:
  ld a, c
  sra a
  sra a
  ld l, a
  call $8003  ; Read character-'0' into arr[C>>2].
  sub '0'
  ld (hl), a
  dec c
  jp p,read

done_read:    ; Now arr = {8,6,4,2,2}, for example.
  ld b, 8     ; For line B=8..1:
line:
  ld l, 4       ; For bar L=4..0:
bar:
  ld a, (hl)
  ld c, '#'       ; C = '#'...
  cp b
  jr nc, not_less
  ld c, ' '       ; But if bar value < B, C = space...
not_less:
  jp nz, not_eq
  ld c, '-'       ; And if bar value == B, C = dash.
not_eq:
  ld a, c         ; Print C.
  call $8000
  dec l
  jp m, endline

  ld a, ' '       ; Print a space and go to the next bar.
  call $8000
  jr bar

endline:
  ld a, '\n'    ; Print a newline and go to the next line.
  call $8000
  djnz line
  halt        ; Done.
