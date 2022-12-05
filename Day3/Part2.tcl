#!/usr/bin/env tclsh

set input [read [open "input.txt" r]]

set Ergebnis ""

set Alphabet "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
set AlphabetMap ""
set i 1

foreach char [split $Alphabet ""] {

    lappend AlphabetMap $char $i
    incr i

}

set Groups ""

for {set i 0} {$i < [llength $input]} {incr i 3} {

    set Group ""
    lappend Group [lindex $input $i] [lindex $input [expr $i + 1]] [lindex $input [expr $i + 2]]
    lappend Groups $Group

}

set CommonChars ""

foreach Group $Groups {

    set Temp ""

    foreach char [split [lindex $Group 0] ""] {
        if {[string match *$char* [lindex $Group 1]] && [string match *$char* [lindex $Group 2]] && ![string match *$char* $Temp]} {
            lappend CommonChars $char
            lappend Temp $char
            break
        }
    }

}

set Ergebnis [expr [string map $AlphabetMap [string map {" " +} $CommonChars]]]

puts $Ergebnis
