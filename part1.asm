;---------------------------------------
; Next Kong - a simple arcade game based off of the SpecBong tutorial
;----------------------------------------

L2_PAGE         equ $12
L2_X            equ $16
L2_Y            equ $17
L2_CLIP         equ $18
CLIP_CTRL       equ $1C
PAL_CTRL        equ $43
PAL_EXT         equ $44
DISP_CTRL       equ $69
L2_CTRL         equ $70
L2_X_MSB        equ $71

    OPT --syntax=abfw --zxnext
    OPT --zxnext=cspect

    DEVICE ZXSPECTRUMNEXT

; Code, Data, and Stack will go in Bank 2 ($8000..$BFFF)
; The Background will go in Banks 9-13

    ORG $8000
start:
    break : nop : nop       ; Debug and Dummy instructions
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

; Load Palette
    nextreg PAL_CTRL,$10    ; Open palette up for reading/writing
    
    ld b,0
    ld hl,BackgroundPalette
LoadPalette:
    ld a,(hl)
    nextreg PAL_EXT,a       ; Write first 8 bits of color
    inc hl
    ld a,(hl)
    nextreg PAL_EXT,a       ; Write last bit of color
    inc hl
    djnz LoadPalette

    jr $

BackgroundPalette:
    INCBIN "norway.nxp"

; Reserve stack space
    ORG $B800
    DS $0800-2,$AA
StackTop:
    DW $AAAA

; Place background image in memory
    MMU 6 n,18
    ORG $C000
    INCBIN "norway.nxi"

; Create nex file
    SAVENEX OPEN "part1.nex",start,StackTop
    SAVENEX CORE 3,0,0
    SAVENEX AUTO
    SAVENEX CLOSE
