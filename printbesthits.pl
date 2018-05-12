#!/usr/bin/perl

#use: printbesthits.pl allxxyy.HS
#output: bestxxyy.HS

$IN=@ARGV[0]; #allsacesace.HS
$F=substr($IN,3,length($IN));
$OUT="best"."$F";
open(OUT,">$OUT");
open(IN,"$IN");

$P="";
while(<IN>)
  {
#blastp output results are listed by decreasing order (or increasing e-values)
#the best hit for each query sequence is its first hit in allsacesace.HS
@tab=split(/\s+/, $_);
print OUT $_ if ( $tab[0] ne $P );
$P=$tab[0];
  }
close(IN);
close(OUT);
