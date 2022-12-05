#!/usr/bin/env tclsh

proc range2list {range} {
    set tempList [split $range -]
    set first [lindex $tempList 0]
    set last [lindex $tempList 1]

    set List ""

    for {set index $first} {$index <= $last} {incr index} {
        lappend List $index
    }

    return $List
}

set input [read [open "input.txt" r]]

set Ergebnis 0

foreach Pair $input {
    set tempList [split $Pair ,]
    set first [lindex $tempList 0]
    set last [lindex $tempList 1]

    set firstList [range2list $first]
    set lastList [range2list $last]

    set FirstInLast 1
    set LastInFirst 1

    foreach num $firstList {
        if {[lsearch $lastList $num] == -1} {
            set FirstInLast 0
            break
        }
    }

    foreach num $lastList {
        if {[lsearch $firstList $num] == -1} {
            set LastInFirst 0
            break
        }
    }

    if {$FirstInLast || $LastInFirst} {
        incr Ergebnis
    }
}

puts $Ergebnis
