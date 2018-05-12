#!/usr/bin/perl

# print Ident in position 0 
#
while (<>)
 {
     @tab = split (/\s+/, $_);
	 print "$tab[0]\n";
 }
