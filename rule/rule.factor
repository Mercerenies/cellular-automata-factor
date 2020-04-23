
USING: cellular.row locals math.ranges kernel math
arrays sequences io ;
IN: cellular.rule

<PRIVATE

: and-neighbors ( n -- arr )
    [ 1 - ] [ ] [ 1 + ] tri 3array ;

: eval-rule-at ( rule row n -- ? )
    and-neighbors get-cells-bitmasked bit? ;

: produce-times ( ..a n quot: ( ..a -- ..a obj ) -- ..a seq )
    [ dip swap ] curry [ dup 0 > [ 1 - t ] [ f ] if ] swap produce nip ; inline

: iterate-times ( ..a obj n quot: ( ..a obj -- ..a obj ) -- ..a seq )
    [ over [ call ] dip ] curry produce-times nip ; inline

PRIVATE>

:: next-row ( row rule -- row )
    <row>
    row minmax-cell [ 1 - ] [ 1 + ] bi* [a,b]
    [
        dup [ rule row ] dip eval-rule-at set-cell
    ] each
    rule row get-default-cell 7 0 ? bit? set-default-cell ;

: iterate-from ( row rule n -- arr )
    swapd [ over next-row ] iterate-times nip ;

: iterate ( rule n -- arr )
    [ starting-row ] 2dip iterate-from ;

:: print-table ( rule width height -- )
    width 2 /i dup -1 * swap
    rule height iterate
    [ -rot [ show-row-bounds print ] 2keep ] each 2drop ;

