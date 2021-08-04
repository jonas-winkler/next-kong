;---------------------------------------
; A simple demo so I could figure out the layout of Layer 2's 320x256 mode
;----------------------------------------

L2_PAGE         equ $12
L2_X            equ $16
L2_Y            equ $17
L2_CLIP         equ $18
CLIP_CTRL       equ $1C
PAL_IDX         equ $40
PAL_CTRL        equ $43
PAL_EXT         equ $44
MMU_6           equ $56
MMU_7           equ $57
DISP_CTRL       equ $69
L2_CTRL         equ $70
L2_X_MSB        equ $71

    OPT --syntax=abfw --zxnext
    OPT --zxnext=cspect

    DEVICE ZXSPECTRUMNEXT

    ORG $8000
start:
    break : nop : nop
    di

; Setup the Layer 2 display
    nextreg DISP_CTRL,$80   ; Turn on Layer 2
    nextreg L2_CTRL,$10     ; Set resolution to 320x256
    nextreg L2_PAGE,9       ; Map screen data to bank 9
    nextreg L2_X,0          ; Set screen offsets
    nextreg L2_X_MSB,0
    nextreg L2_Y,0
    nextreg CLIP_CTRL,$01   ; Set clipping so whole screen is visible
    nextreg L2_CLIP,0
    nextreg L2_CLIP,159
    nextreg L2_CLIP,0
    nextreg L2_CLIP,255

; Experience all the colors!
    ld b,0
    ld a,0
FillColors:
    push bc
    call FillScreen
    pop bc
    inc a
    djnz FillColors

    jr $

FillScreen:
    nextreg MMU_6,18
    nextreg MMU_7,19
    ld hl,$C000
    ld b,64
    call FillBank

    nextreg MMU_6,20
    nextreg MMU_7,21
    ld hl,$C000
    ld b,64
    call FillBank

    nextreg MMU_6,22
    nextreg MMU_7,23
    ld hl,$C000
    ld b,64
    call FillBank

    nextreg MMU_6,24
    nextreg MMU_7,25
    ld hl,$C000
    ld b,64
    call FillBank

    nextreg MMU_6,26
    nextreg MMU_7,27
    ld hl,$C000
    ld b,64
    call FillBank

    ret

FillBank:
    push bc
    
    ld b,0
FillColumn:
    ld (hl),a
    inc hl
    djnz FillColumn

    pop bc
    djnz FillBank
    ret

; Reserve stack space
    ORG $B800
    DS $0800-2,$AA
StackTop:
    DW $AAAA

; Create nex file
    SAVENEX OPEN "rainbow.nex",start,StackTop
    SAVENEX CORE 3,0,0
    SAVENEX AUTO
    SAVENEX CLOSE
