#!/usr/bin/env tclsh

set input [read [open "input.txt" r]]

set Ergebnis 0

proc GrößeErmitteln {Ordner} {
    global Dateien

    set size 0

    dict for {File Filesize} $Dateien($Ordner) {
        if {$Filesize == "dir"} {
            if {$Ordner == "/"} {
                incr size [GrößeErmitteln "/$File"]
            } else {
                incr size [GrößeErmitteln "$Ordner/$File"]
            }
        } else {
            incr size $Filesize
        }
    }
    return $size
}

set Lines [split $input \n]

set AktuellerPfad ""
array set Dateien {}
global Dateien

foreach Line $Lines {
    if {[string index $Line 0] == "$"} {
        if {[string match "$ cd*" $Line]} {
            set Ordner [string map {"$ cd " ""} $Line]
            if {$Ordner == ".."} {
                set AktuellerPfad [string replace $AktuellerPfad [string last / $AktuellerPfad] end]
                if {$AktuellerPfad == ""} {
                    set AktuellerPfad "/"
                }
            } else {
                if {$Ordner == "/"} {
                    set AktuellerPfad "/"
                } elseif {[string index $AktuellerPfad end] == "/"} {
                    append AktuellerPfad $Ordner
                } else {
                    append AktuellerPfad /$Ordner
                }
            }
        }
    } else {
        set Datei [split $Line]
        lappend Dateien($AktuellerPfad) [lindex $Datei 1] [lindex $Datei 0]
    }
}

foreach Ordner [array names Dateien] {
    set Size [GrößeErmitteln $Ordner]
    if {$Size <= 100000} {
        incr Ergebnis $Size
    }
}

puts $Ergebnis
