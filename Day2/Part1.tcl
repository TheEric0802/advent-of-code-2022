#!/usr/bin/env tclsh

set input [read [open "input.txt" r]]

set Ergebnis ""

set PunkteListe ""

foreach {Gegner Ich} $input {

  set Punkte 0

  if {$Gegner == "A" && $Ich == "Y" || $Gegner == "B" && $Ich == "Z" || $Gegner == "C" && $Ich == "X"} {

    #Gewonnen
    incr Punkte 6

  } elseif {$Gegner == "A" && $Ich == "Z" || $Gegner == "B" && $Ich == "X" || $Gegner == "C" && $Ich == "Y"} {

    #Verloren
    incr Punkte 0

  } else {

    #Unentschieden
    incr Punkte 3

  }

  switch $Ich {

    "X" {incr Punkte 1}

    "Y" {incr Punkte 2}

    "Z" {incr Punkte 3}

  }

  lappend PunkteListe $Punkte

}

set Ergebnis [expr [string map {" " "+"} $PunkteListe]]

puts $Ergebnis
