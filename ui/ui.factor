
USING: ui ui.gadgets math formatting kernel accessors arrays
locals cellular.rule sequences opengl math.ranges cellular.row
ui.render colors.constants namespaces math.vectors ;
IN: cellular.ui

TUPLE: cellular-gadget < gadget
    { radius integer }
    rows ;

CONSTANT: cell-size 16

: draw-cell ( ? y x -- )
    [ COLOR: black COLOR: white ? gl-color ] 2dip
    swap 2array cell-size v*n origin get v+
    cell-size cell-size 2array
    gl-fill-rect ;

:: draw-row ( row y r -- )
    r dup -1 * swap [a,b] [
        row over get-cell y rot r + draw-cell
    ] each ;

M: cellular-gadget pref-dim*
    [ radius>> 2 * 1 + cell-size * ] [ rows>> length cell-size * ] bi 2array ;

M: cellular-gadget draw-gadget*
    [ radius>> ] [ rows>> ] bi
    [let :> rows :> radius
     [
         rows [ radius draw-row ] each-index
     ] do-matrix ] ;

:: <cellular-gadget> ( rule width height -- gadget )
    cellular-gadget new width 2 /i >>radius rule height iterate >>rows ;

: show-ui ( rule width height -- )
    pick [ <cellular-gadget> ] dip "Rule %d" sprintf open-window ;
