#!/usr/bin/perl

# in use with local mcl procedure
# replace ORF identifications by their corresponding identification number
# as obtained from the index xx.tab (obtained by mcltabform.pl)
# and replace e-values by their corresponding log values.

#Use xx.tab and allxxseqnew.HS > allxxnum &

$IN=@ARGV[0]; # xx.tab: number ORF_name
$ALL=@ARGV[1]; # allxxseqnew.HS

open(IN,"$IN") || "die can't open $IN";
$K=0;
while(<IN>)
{
    if ( $K > 1 ) { 
    @tab=split(/\s+/, $_);
#use hash structure
    $ID{$tab[1]} = $tab[0];
###    $ORF{$tab[0]} = $tab[1];
                  }#if $K
    $K++;
}#while IN
close(IN);

open(A, "$ALL") | "die can't open $ALL";
while(<A>)
{
    @tab=split(/\s+/, $_);

  $K=$tab[4];   if ($tab[4] == 0.0 ) { $K=1e-300; }
  $l=-log($K); 
  print "$ID{$tab[0]}\t$tab[1]\t$ID{$tab[2]}\t$tab[3]\t$tab[4]\t$l\n";

} #while A
