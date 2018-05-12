#!/usr/bin/perl

#count occurrences of multiple hits per query sequence
#Use countmmhits.pl allxxyy.HS > freqorfxx.yy

$IN=@ARGV[0];
$P="";
open(IN,"$IN") || die "can't find $IN";
while(<IN>)
  {

@tab=split(/\s+/, $_);
$COUNT{$tab[0]}++;
if ( length ($P) > 1 && $P ne $tab[0] ) { print "$P\t$COUNT{$P}\n"; }

$P=$tab[0];
  }
 print "$P\t$COUNT{$P}\n";
close(IN);
