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

set CommonChars ""

foreach line $input {

    set length [string length $line]
    set left [string range $line 0 [expr $length/2-1]]
    set right [string range $line [expr $length/2] [expr $length-1]]
    set Temp ""

    foreach char [split $left ""] {
        if {[string match *$char* $right]} {
            if {![string match *$char* $Temp]} {
                lappend CommonChars $char
            }
            append Temp $char
        }
    }

}

set Ergebnis [expr [string map $AlphabetMap [string map {" " +} $CommonChars]]]

puts $Ergebnis
