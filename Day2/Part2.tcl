#!/usr/bin/env tclsh

set input [read [open "input.txt" r]]

set Ergebnis ""

set PunkteListe ""

foreach {Gegner Ende} $input {

  set Punkte 0
  set Ich ""

  switch $Ende {

    "X" {

      #Verlieren
      incr Punkte 0

      switch $Gegner {

        "A" {set Ich "Z"}

        "B" {set Ich "X"}

        "C" {set Ich "Y"}

      }

    }

    "Y" {

      #Unentschieden
      incr Punkte 3

      switch $Gegner {

        "A" {set Ich "X"}

        "B" {set Ich "Y"}

        "C" {set Ich "Z"}

      }

    }

    "Z" {

      #Gewinnen
      incr Punkte 6

      switch $Gegner {

        "A" {set Ich "Y"}

        "B" {set Ich "Z"}

        "C" {set Ich "X"}

      }

    }

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
