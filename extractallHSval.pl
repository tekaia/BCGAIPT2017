#!/usr/bin/perl

#extract columns from the original intra-species allsacesace.HS file to comply with the structure of allsacesaceseqnew.HS (expected for mcl scripts).

$IN=@ARGV[0]; #input file allsacesace.HS

#extract species code
$spec1 = substr($IN,3, 4);
$spec2 = substr($IN,7, 4);
$OUT = "all"."$spec1"."$spec2"."seqnew.HS";

open (OUT, ">$OUT");
open(IN,"$IN");
while(<IN>)
{
    @tab=split(/\s+/,$_);
    print OUT "$tab[0]\t$tab[3]\t$tab[1]\tHS\t$tab[$#tab-1]\n";
}
close (IN); close (OUT);
