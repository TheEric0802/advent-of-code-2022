#!/usr/bin/env tclsh

set input [read [open "input.txt" r]]

set Ergebnis ""

set Lines [split $input "\n"]

set Crates ""
set Moves ""

set afterEmptyLine 0

foreach Line $Lines {
    if {$Line == ""} {
        set afterEmptyLine 1
    } else {
        if {$afterEmptyLine} {
            lappend Moves $Line
        } else {
            lappend Crates $Line
        }
    }
}

set firstLine 1
set AnzahlStacks 0
array set Stacks {}

foreach Line [lreverse $Crates] {
    if {$firstLine} {
        set firstLine 0
        set AnzahlStacks [lindex $Line end]
    } else {
        set chars [split $Line ""]
        for {set index 1; set StackNumber 1} {$index < [llength $chars]} {incr index 4; incr StackNumber} {
            lappend Stacks($StackNumber) [lindex $chars $index]
        }
    }
}

foreach Stack [array names Stacks] {
    while {[lindex $Stacks($Stack) end] == " "} {
        set Stacks($Stack) [lreplace $Stacks($Stack) end end]
    }
}

foreach Move $Moves {
    for {set index 0} {$index < [dict get $Move move]} {incr index} {
        lappend Stacks([dict get $Move to]) [lindex $Stacks([dict get $Move from]) end]
        set Stacks([dict get $Move from]) [lreplace $Stacks([dict get $Move from]) end end]
    }
}

foreach Stack [lsort -integer [array names Stacks]] {
    append Ergebnis [lindex $Stacks($Stack) end]
}



puts $Ergebnis
