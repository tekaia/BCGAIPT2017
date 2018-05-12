#!/usr/bin/perl

while(<>)
{
    @tab=split(/\s+/, $_);
               $SP=substr($tab[0],0,5);
               $tab[1]=$SP."$tab[1]";
               print "$tab[0]\t$tab[1]\t$tab[2]\n";
}
