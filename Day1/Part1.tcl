#!/usr/bin/env tclsh

set input [read [open "input.txt" r]]
set Liste [string map {++ \n} [string map {\n +} $input]]

set ListeAusgerechnet ""

foreach line $z {lappend ListeAusgerechnet [expr $line]}

set max [tcl::mathfunc::max {*}$ListeAusgerechnet]

puts $max
