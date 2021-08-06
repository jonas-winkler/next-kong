;----------------------------------------
; Couldn't figure out converting png to sprite sheets, so I did it manually here.
;----------------------------------------

SmileySprite:
    dh "00000BBBBBB00000"
    dh "000BBAAAAAABB000"
    dh "00BAAAAAAAAAAB00"
    dh "0BAAABAAAABAAAB0"
    dh "0BAAABAAAABAAAB0"
    dh "BAAAABAAAABAAAAB"
    dh "BAAAABAAAABAAAAB"
    dh "BAAAAAAAAAAAAAAB"
    dh "BAAAAAAAAAAAAAAB"
    dh "BAABAAAAAAAABAAB"
    dh "BAABAAAAAAAABAAB"
    dh "0BAABAAAAAABAAB0"
    dh "0BAAABBBBBBAAAB0"
    dh "00BAAAAAAAAAAB00"
    dh "000BBAAAAAABB000"
    dh "00000BBBBBB00000"

FishSprite:
    dh "0000011000000000"
    dh "0000122110000001"
    dh "0000121221100001"
    dh "0000121212210012"
    dh "0000011111100012"
    dh "0001122299910121"
    dh "0112222222991112"
    dh "1222222222991222"
    dh "1221222299991112"
    dh "1222229999991121"
    dh "1222999919991012"
    dh "0111999111010012"
    dh "0000111121100001"
    dh "0000122122110001"
    dh "0000011011100000"
    dh "0000000000000000"

TreeSprite:
    dh "0000333300000000"
    dh "0003333333000000"
    dh "0033554633300000"
    dh "0345556463300000"
    dh "0354566666330000"
    dh "0355566666330000"
    dh "0355546664643000"
    dh "0335554554433000"
    dh "0333555444533000"
    dh "0033333443330000"
    dh "0000033443330000"
    dh "0000000443300000"
    dh "0000000440000000"
    dh "0000000440000000"
    dh "0000000444000000"
    dh "0000004444440000"

AxeSprite:
    dh "00000000BB0000BB"
    dh "0000000B77B00B8B"
    dh "000000B777B0B8B0"
    dh "00000B77777B8B00"
    dh "0000B77777B8B000"
    dh "0000B7777B8BB000"
    dh "00000BB7B8B77B00"
    dh "0000000B8B777B00"
    dh "000000B8B0B77B00"
    dh "00000B8B00B7B000"
    dh "0000B8B0000B0000"
    dh "000B8B0000000000"
    dh "00B8B00000000000"
    dh "0B8B000000000000"
    dh "B8B0000000000000"
    dh "BB00000000000000"

SpritePalette:
    db $00,$00      ; Transparent
    db $05,$00      ; Dark Blue
    db $1B,$01      ; Light Blue
    db $28,$01      ; Dark Green
    db $44,$00      ; Dark Brown
    db $4D,$00      ; Medium Green
    db $96,$00      ; Light Green
    db $B6,$01      ; Gray
    db $D1,$01      ; Light Brown
    db $E1,$01      ; Red
    db $FC,$00      ; Yellow
    db $00,$00      ; Black
