  push de     ; always $0000
  call $8003  ; getchar
  jr nc, ok   ; continue if not EOF
  halt
ok:
  ; execution falls through many NOPs to $8000 (putchar)
  ; then returns to pushed address ($0000, start of code)
