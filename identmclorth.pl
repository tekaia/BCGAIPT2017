#!/usr/bin/perl

#construct nomorth.mclorth from nomorth and ORTH.mclclusters
#Use identmclorth.pl nomorth ORTH.mclclusters&
#output nomorth.mclorth including orfident (from nomorth) <tab> mcl_orth_cluster

$ID=@ARGV[0];
$CLUST=@ARGV[1];

#For each ident identify its corresponding cluster
open(CLUST,"$CLUST");
while(<CLUST>)
{

    @tab=split(/\s+/,$_);
    $CLUSTID{$tab[0]} = $tab[1];
}
close(CLUST)

    $SPEC=$IN;
$OUT = "$ID.mclorth";
open(OUT,">$OUT");

open(ID,"$ID");
while(<ID>)
{
    if ($CLUSTID{$tab[0]}) { print OUT "$tab[0]\t$CLUSTID{$tab[0]}; $ifalg=1;}
}
close(ID);
close (OUT);

