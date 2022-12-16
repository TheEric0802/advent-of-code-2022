#!/usr/bin/env tclsh

set input [read [open "input.txt" r]]

set Ergebnis ""

proc GetScore {Reihe Spalte} {
    global Reihen
    global Spalten
    global TreeMap

    set Score 0
    set Links 0
    set Oben 0
    set Rechts 0
    set Unten 0


    if {$Reihe > 0 && $Spalte > 0 && $Reihe < $Reihen-1 && $Spalte < $Spalten-1} {
        for {set index [expr $Spalte +1]} {$index < $Spalten} {incr index} {
            if {[lindex $TreeMap $Reihe $index] <= [lindex $TreeMap $Reihe $Spalte]} {
                incr Rechts
                if {[lindex $TreeMap $Reihe $index] == [lindex $TreeMap $Reihe $Spalte]} {
                    break
                }
            } else {break}
        }
        for {set index [expr $Reihe +1]} {$index < $Reihen} {incr index} {
            if {[lindex $TreeMap $index $Spalte] <= [lindex $TreeMap $Reihe $Spalte]} {
                incr Unten
                if {[lindex $TreeMap $index $Spalte] == [lindex $TreeMap $Reihe $Spalte]} {
                    break
                }
            } else {break}
        }
        for {set index [expr $Spalte -1]} {$index >= 0} {incr index -1} {
            if {[lindex $TreeMap $Reihe $index] <= [lindex $TreeMap $Reihe $Spalte]} {
                incr Links
                if {[lindex $TreeMap $Reihe $index] == [lindex $TreeMap $Reihe $Spalte]} {
                    break
                }
            } else {break}
        }
        for {set index [expr $Reihe -1]} {$index >= 0} {incr index -1} {
            if {[lindex $TreeMap $index $Spalte] <= [lindex $TreeMap $Reihe $Spalte]} {
                incr Oben
                if {[lindex $TreeMap $index $Spalte] == [lindex $TreeMap $Reihe $Spalte]} {
                    break
                }
            } else {break}
        }

        set Score [expr $Links*$Oben*$Rechts*$Unten]
    }

    return $Score
}

set TreeMap ""

for {set index 0} {$index < [llength $input]} {incr index} {
    lappend TreeMap [split [lindex $input $index] ""]
}

set Reihen [llength $TreeMap]
set Spalten [llength [lindex $TreeMap 0]]

for {set Reihe 0} {$Reihe < $Reihen} {incr Reihe} {
    for {set Spalte 0} {$Spalte < $Spalten} {incr Spalte} {
        set Score [GetScore $Reihe $Spalte]
        if {$Score > $Ergebnis} {
            set Ergebnis $Score
        }
    }
}

puts $Ergebnis
