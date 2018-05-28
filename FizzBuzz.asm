  ld bc, $0305   ; B = Fizz countdown.  C = Buzz countdown.
  ld h, 10       ; Constant; also used as '\n'
next:
  inc d          ; Ones counter
  ld a, d

  ; We do something tricky here. An alias of putchar lives at $0008
  ; (the putchar label) so that we can RST $8 instead of CALL $8000.
  ; But instead of JR-ing around it (from $0006 to `whew`) we put a
  ; 36 opcode [LD (HL),&00] at $0007 that trips up the 4 following bytes
  ; and turns them into effective NOPs. (CALL $7f22 is okay because
  ; we will simply nop-slide into $8000 from there.)
  ;
  ; ...All this saves just one byte, sadly.

  db $36      ; "36cd 227fc9" is harmless:
putchar:      ;   ld (hl), $cd        ; "cd227f c9" calls putchar:
  call $7f22  ;   ld ($c97f), hl      ;   call $7f22
  ret                                 ;   ret

whew:
  cp h           ; Check if D == 10
  jr nz, no_tens
  ld d, l        ; Set D = 0.
  inc e          ; Increment tens counter.
no_tens:
  ccf            ; Clear carry flag. We set carry after Fizzing or Buzzing.
  djnz no_fizz   ; Decrement Fizz counter; if non-zero, don't Fizz.

  ld b, 3        ; Reset Fizz counter, print Fizz, set carry.
  ld a, 'F'
  rst putchar
  ld a, 'i'
  rst putchar
  ld a, 'z'
  rst putchar
  rst putchar
  scf

no_fizz:
  dec c          ; Decrement Buzz counter.
  jr nz, no_buzz ; If non-zero, don't Buzz.

  ld c, 5        ; Reset Buzz counter, print Buzz, set carry.
  ld a, 'B'
  rst putchar
  ld a, 'u'
  rst putchar
  ld a, 'z'
  rst putchar
  rst putchar
  scf

no_buzz:
  jr c, endline   ; If carry is set, skip printing the number.
  ld a, e         ; Check the tens digit...
  or a
  jr z, skip_zero ; If it is zero, skip printing it.
  add '0'         ; Print the tens digit.
  rst putchar
skip_zero:
  ld a, d
  add '0'         ; Print the ones digit.
  rst putchar

endline:
  ld a, h         ; Print a newline.
  rst putchar
  ld a, e
  cp h            ; Loop if the tens digit isn't 10.
  jr nz, next
  halt
