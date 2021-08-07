;----------------------------------------
; Demo to test/learn how the Sprite system works
;----------------------------------------

SPR_SEL         equ $303B

SPR_ATTR        equ $57
SPR_DATA        equ $5B

L2_PAGE         equ $12
SPR_CTRL        equ $15
L2_X            equ $16
L2_Y            equ $17
L2_CLIP         equ $18
SPR_CLIP        equ $19
CLIP_CTRL       equ $1C
PAL_IDX         equ $40
PAL_CTRL        equ $43
PAL_EXT         equ $44
SPR_TRANS       equ $4B
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

; Setup the Layer 2 Background
    nextreg DISP_CTRL,$80   ; Turn on Layer 2
    nextreg L2_CTRL,$10     ; Set resolution to 320x256
    nextreg L2_PAGE,9       ; Map screen data to bank 9 nextreg L2_X,0          ; Set screen offsets
    nextreg L2_X_MSB,0
    nextreg L2_Y,0
    nextreg CLIP_CTRL,$01   ; Set clipping so whole screen is visible
    nextreg L2_CLIP,0
    nextreg L2_CLIP,159
    nextreg L2_CLIP,0
    nextreg L2_CLIP,255

; Fill background layer with white
    ld a,255
    call FillScreen

    nextreg SPR_CTRL,$23    ; SLU draw order, sprites enabled, etc...
    nextreg CLIP_CTRL,$02   ; Set up clipping for sprites
    nextreg SPR_CLIP,0
    nextreg SPR_CLIP,159
    nextreg SPR_CLIP,0
    nextreg SPR_CLIP,255

; Load sprite palette
    nextreg PAL_CTRL,$20    ; Open sprite palette up for editing
    
    ld b,PaletteSize
    ld hl,SpritePalette
LoadPalette:
    ld a,(hl)
    nextreg PAL_EXT,a
    inc hl
    ld a,(hl)
    nextreg PAL_EXT,a
    inc hl
    djnz LoadPalette

; Make 0 the transparency color
    nextreg SPR_TRANS,0
    
    ld bc,SPR_SEL           ; Select sprite index 0
    ld a,0
    out (c),a

; Upload Sprite Pattern data
    ld b,128
    ld hl,SmileySprite
    ld c,SPR_DATA
    otir

    ld b,128
    ld hl,FishSprite
    otir

    ld b,128
    ld hl,TreeSprite
    otir

    ld b,128
    ld hl,AxeSprite
    otir

    ld bc,SPR_SEL           ; Select sprite index 0 again
    ld a,0
    out (c),a

; Upload Sprite Attribute data
    ld b,4*5
    ld hl,Smiley
    ld c,SPR_ATTR
    otir

    jr $

; Fills screen with whatever palette index is in a register
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

Smiley:
    db $00
    db $00
    db $00
    db $C0
    db $80
Fish:
    db $35
    db $35
    db $00
    db $C0
    db $C0
Tree:
    db $7f
    db $7f
    db $00
    db $C1
    db $80
Axe:
    db $B5
    db $B6
    db $00
    db $C1
    db $C0

; Include sprite and sprite palette data
    INCLUDE "test-sprites.i.asm"

; Create nex file
    SAVENEX OPEN "sprite-test.nex",start,StackTop
    SAVENEX CORE 3,0,0
    SAVENEX AUTO
    SAVENEX CLOSE
