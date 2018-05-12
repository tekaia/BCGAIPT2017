#!/usr/bin/perl

#construct $GEN.mclpar from $GEN.ident and $GEN.mclclusters
#Use identmclpar.pl $GEN.ident $GEN.mclclusters&
#output $GEN.mclpar

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
    $SPEC =~ s/\.ident//g;
$OUT = $SPEC.".mclpar";
open(OUT,">$OUT");

open(ID,"$GEN.ident");
while(<ID>)
{
    $iflag=0;
    if ($CLUSTID{$tab[0]}) { print OUT "$tab[0]\t$CLUSTID{$tab[0]}; $ifalg=1;}
    if ($iflag == 0      ) { print OUT "$tab[0]\tSingle\n"; }
}
close(ID);
close (OUT);

