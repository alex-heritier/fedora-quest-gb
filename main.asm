; Some random gameboy game
; Author: Alex Heritier
; Date: February 15, 2018

SECTION "BootJump", ROM0[$100]
  jp $150

SECTION "Init", ROM0[$150]
init:
  ld A, $11 ; setup LCD
  ld [$FF00+$40], A
  ld A, $C0 ; setup background palette
  ld [$FF00+$47], A
; copy Tiles to VRAM
.setup_vram
  ld BC, tiles_start
  ld HL, $8000
.vram_loop
  ld A, [BC]
  inc BC
  ld [HL+], A
  ld A, L
  ld DE, tiles_end
  cp E
  jr nz, .vram_loop
.setup_bg_map
  xor A
  ld HL, $9BFF
.clear_bg_map
  ld [HL-], A
  bit 4, H
  jr nz, .clear_bg_map
.show_intro
  ld HL, $9821
  ld A, $1
  ld [HL+], A
  ld A, $2
  ld [HL+], A
  ld A, $4
  ld [HL+], A
  ld A, $4
  ld [HL+], A
  ld A, $5
  ld [HL+], A
.turn_on_lcd
  ld A, [$FF00+$40]
  or $80
  ld [$FF00+$40], A
.game_loop
  call hang
hang:
  jr hang

SECTION "Tiles", ROMX
tiles_start:
char_space:
db $00, $00
db $00, $00
db $00, $00
db $00, $00
db $00, $00
db $00, $00
db $00, $00
db $00, $00
char_cap_h:
db $66, $66
db $66, $66
db $66, $66
db $7E, $7E
db $7E, $7E
db $66, $66
db $66, $66
db $66, $66
char_e:
db $00, $00
db $38, $38
db $7C, $7C
db $64, $64
db $7C, $7C
db $60, $60
db $7C, $7C
db $38, $38
char_i:
db $00, $00
db $18, $18
db $18, $18
db $00, $00
db $18, $18
db $18, $18
db $18, $18
db $18, $18
char_l:
db $18, $18
db $18, $18
db $18, $18
db $18, $18
db $18, $18
db $18, $18
db $18, $18
db $18, $18
char_o:
db $00, $00
db $00, $00
db $7E, $7E
db $7E, $7E
db $66, $66
db $66, $66
db $7E, $7E
db $7E, $7E
char_emark:
db $C0, $C0
db $C0, $C0
db $C0, $C0
db $C0, $C0
db $C0, $C0
db $00, $00
db $C0, $C0
db $C0, $C0
tiles_end:
