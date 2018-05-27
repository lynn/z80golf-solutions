start:
  ; The list of smiles -- their ASCII values are harmless instructions.
  db "|" ; ld a, h
  db ")" ; add hl, hl
  db "D" ; ld b, h

  ; Read the input, and map '1' -> 0, '2' -> 1, '3' -> 2.
  call $8003  ; a = getchar()
  sub 49

  ; Point HL to the correct smile character:
  ld l,a

  ; Also set up D, which we count down each line.
  ld d,a

line:
  ; Increment E by 10
  ld a, e 
  add a, 10 
  ld e, a

  ld a, ':'
  rst $38  ; putchar

  ; Print E smiles, using B (and DJNZ) as a counter.
  ld b, e
smiles:
  ld a, (hl)
  rst $38  ; putchar
  djnz smiles

  ; Print a newline, decrement D and loop if D is non-negative.
  ld a, '\n'
  rst $38  ; putchar
  dec d
  jp p, line
  halt
