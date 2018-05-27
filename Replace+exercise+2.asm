restart:
  push de  ; DE = $0000 always.
  call $8003
  jr c, jrnz_halt+1  ; On EOF, jump to the HALT inside the JR NZ operand.
ok:

  cp '4'
jrnz_halt:
  ; If not a '4', jump into the sea of NOPs at the end of the program.
  ; This will fall through to putchar, then return to the $0000 we pushed.
  ; We use $76 as the operand so that it can be reused as HALT.
  jr nz, $+2 + $76  ; $76 = HALT opcode

mute:
  ; If A was a '4', skip until we find a 1 again.
  call $8003
  cp '1'
  jr nz, mute
  ; Then fall through to putchar, print the 1, ret to $0000.
