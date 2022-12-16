#!/usr/bin/env tclsh

set input [read [open "input.txt" r]]

set Ergebnis ""

proc GetSichtbar {Reihe Spalte} {
    global Reihen
    global Spalten
    global TreeMap

    set Sichtbar TRUE

    set SichtbarLinks TRUE
    set SichtbarOben TRUE
    set SichtbarRechts TRUE
    set SichtbarUnten TRUE

    if {$Reihe > 0 && $Spalte > 0 && $Reihe < $Reihen-1 && $Spalte < $Spalten-1} {
        for {set index 0} {$index < $Reihe} {incr index} {
            if {[lindex $TreeMap $index $Spalte] >= [lindex $TreeMap $Reihe $Spalte]} {
                set SichtbarOben FALSE
            }
        }
        for {set index [expr $Reihen-1]} {$index > $Reihe} {incr index -1} {
            if {[lindex $TreeMap $index $Spalte] >= [lindex $TreeMap $Reihe $Spalte]} {
                set SichtbarUnten FALSE
            }
        }
        for {set index 0} {$index < $Spalte} {incr index} {
            if {[lindex $TreeMap $Reihe $index] >= [lindex $TreeMap $Reihe $Spalte]} {
                set SichtbarLinks FALSE
            }
        }
        for {set index [expr $Spalten-1]} {$index > $Spalte} {incr index -1} {
            if {[lindex $TreeMap $Reihe $index] >= [lindex $TreeMap $Reihe $Spalte]} {
                set SichtbarRechts FALSE
            }
        }
        if {!$SichtbarLinks && !$SichtbarOben && !$SichtbarRechts && !$SichtbarUnten} {
            set Sichtbar FALSE
        }
    }
    return $Sichtbar
}

set TreeMap ""

for {set index 0} {$index < [llength $input]} {incr index} {
    lappend TreeMap [split [lindex $input $index] ""]
}

set Reihen [llength $TreeMap]
set Spalten [llength [lindex $TreeMap 0]]

set AnzahlSichtbar 0

for {set Reihe 0} {$Reihe < $Reihen} {incr Reihe} {
    for {set Spalte 0} {$Spalte < $Spalten} {incr Spalte} {
        if {[GetSichtbar $Reihe $Spalte]} {
            incr AnzahlSichtbar
        }
    }
}

set Ergebnis $AnzahlSichtbar

puts $Ergebnis
