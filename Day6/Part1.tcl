#!/usr/bin/env tclsh

set input [read [open "input.txt" r]]

set Ergebnis ""

for {set index 3} {$index < [string length $input]} {incr index} {
    set substr [string range $input [expr $index-3] $index]

    set marker 1

    foreach char [split $substr ""] {
        if {[string first $char $substr] != [string last $char $substr]} {
            set marker 0
            break
        }
    }
    
    if {$marker == 1} {
        set Ergebnis [expr $index + 1]
        break
    }
}

puts $Ergebnis
