  db 39 ^ 'H'  ; 6f  ld l, a
  db 39 ^ 'e'  ; 42  ld b, d
  db 39 ^ 'l'  ; 4b  ld c, e
  db 39 ^ 'l'  ; 4b  ld c, e
  db 39 ^ 'o'  ; 48  ld c, b
  db 39 ^ ','  ; 0b  dec bc
  db 39 ^ ' '  ; 07  rlca
  db 39 ^ 'w'  ; 50  ld d, b
  db 39 ^ 'o'  ; 48  ld c, b
  db 39 ^ 'r'  ; 55  ld d, l
  db 39 ^ 'l'  ; 4b  ld c, e
  db 39 ^ 'd'  ; 43  ld b, e
  db 39 ^ '!'  ; 06  ld b,
  halt         ; 76        $76   <- program ends when we jump here!
  ld a, (hl)
  inc hl
  push hl
  xor 39       ; fall into putchar and "return" to HL.
