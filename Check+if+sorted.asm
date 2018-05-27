restart:
  ld c, '1'     ; "Result" (changed to '0' when unsorted pair is found).
  ld b, d       ; "Previous character". D is always 0!
next:
  call $8003
  jr c, final   ; Detect EOF
  cp '\n'       ; Detect end of line
  jr z, endline
  cp b          ; Is this >= previous?
  jp p, ok
  ld c, '0'     ; If not, set result to '0'
ok:
  ld b, a
  jr next
endline:
  ld a, c       ; Print result
  call $8000    ; With RST $38 here, testcase 3 timed out. RST is very slow...
  ld a, '\n'
  rst $38
  jr restart
final:          ; Print final result and halt.
  ld a, c
  rst $38
  halt

