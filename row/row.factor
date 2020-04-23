
USING: kernel hashtables accessors assocs math math.order
math.ranges locals sequences ;
IN: cellular.row

TUPLE: row
    { contents hashtable }
    { default boolean } ;

<PRIVATE

: update-minmax ( min max n -- min max )
    swap over [ min ] [ max ] 2bi* ;

PRIVATE>

: <row> ( -- row )
    20 <hashtable> f row boa ;

: set-cell ( row n ? -- row )
    swap pick contents>> set-at ;

: set-default-cell ( row ? -- row )
    >>default ;

: get-default-cell ( row -- ? )
    default>> ;

: get-cell ( row n -- ? )
    [ dup contents>> ] dip ?of [ nip ] [ drop default>> ] if ;

:: get-cells-bitmasked ( row seq -- n )
  seq [ row swap get-cell ] map 0 [ [ 2 * ] dip 1 0 ? + ] reduce ;

: starting-row ( -- row )
  <row> 0 t set-cell ;

: minmax-cell ( row -- min max )
    [ 0 0 ] dip contents>>
    [
        drop update-minmax
    ] assoc-each ;

: min-cell ( row -- min )
    minmax-cell drop ;

: max-cell ( row -- max )
    minmax-cell nip ;

:: show-row-bounds ( row min max -- str )
    min max [a,b] [ row swap get-cell CHAR: X CHAR: \s ? ] "" map-as ;

: show-row ( row -- str )
    dup minmax-cell show-row-bounds ;
