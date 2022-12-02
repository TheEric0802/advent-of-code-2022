#!/usr/bin/env tclsh

set input [read [open "input.txt" r]]
set Liste [string map {++ \n} [string map {\n +} $input]]
set ListeAusgerechnet ""

foreach line $z {lappend ListeAusgerechnet [expr $line]}

set Ergebnis 0

for {set i 0} {$i < 3} {incr i} {

  set max 0
  set max [tcl::mathfunc::max {*}$ListeAusgerechnet]
  set ListeAusgerechnet [lreplace $ListeAusgerechnet [lsearch $ListeAusgerechnet $max] [lsearch $ListeAusgerechnet $max] "0"]
  set Ergebnis [expr $Ergebnis + $max]

}

puts $Ergebnis
