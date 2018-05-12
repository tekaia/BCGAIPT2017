#!/usr/bin/env perl

#Use: printnshits xx.ident bestxxxx.HS
#output: bestXX.NS
#print single proteins bestxxxx.NS

$ID=@ARGV[0]; # list of all sequence Identifications
$B=@ARGV[1]; #file of best hits bestxxxx.HS

$F=substr($B, 0, length($B)-2 );
$NS="$F"."NS";
open(OUT,">$NS");

open(B,"$B");
while(<B>)
  {
@tab=split(/\s+/, $_);
$IDB{$tab[0]} = $tab[0];
  }
close(B);

open(ID,"$ID");
while(<ID>)
  {
@tab=split(/\s+/, $_);
if ( $IDB{$tab[0]} ) { next; }
print OUT $_;
  }
close(OUT); close(ID);
