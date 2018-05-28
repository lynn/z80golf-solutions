; a,b,c,d,e; main() {
;   for (c=1;c<=9;c++) for (d=1;d<=9;d++) for (e=1;e<=9;e++)
;   if (d+c*e <= 9) {
;     for (a=d+'0', b=c+1+1; --b; a+=e) putchar(a);
;     putchar('\n');
;   }
; }


nextc:        ; For C=1 to 9:
  inc c
  ld d, l
nextd:        ; For D=1 to 9:
  inc d
  ld e, l
nexte:        ; For E=1 to 9:
  inc e
  ld a, d
  ld b, c
mul:          ; Compute A = D+C*E.
  add e
  djnz mul
  cp 10       ; If A >= 10, skip this tuple.
  jr nc, skip
  ld a, d
  add '0'
  ld b, c
  inc b
put:          ; Otherwise, print C+1 characters (D+'0', D+'0'+E, D+'0'+2E, ...)
  rst $38
  add e
  djnz put
  ld a, '\n'  ; Followed by a newline.
  rst $38
skip:
  ld h, 9     ; This is one byte shorter than having to `cp 9` thrice.
  ld a, e
  cp h
  jr nz, nexte
  ld a, d
  cp h
  jr nz, nextd
  ld a, c
  cp h
  jr nz, nextc
  halt
