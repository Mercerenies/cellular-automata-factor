
USING: io cellular.rule cellular.ui ui kernel ;
IN: cellular

: run-in-console ( rule width height -- )
    print-table ;

: run-in-gui ( rule width height -- )
    [ show-ui ] 3curry with-ui ;
