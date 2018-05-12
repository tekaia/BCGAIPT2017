#!/usr/bin/perl

#statistics on gold data

open(IN,"goldData.txt");
open(OUT,">goldDatafinal.txt");

while(<IN>)
  {
#replace white space by "_"
s# #_#go;
@tab=split(/[\t]/,$_);

#Extract columns corresponding to: GOLD_ID, PROJECT_TYPE, PROJECT_STATUS,SEQUENCING_STATUS,DOMAIN, PHYLUM and SPECIES
print OUT "$tab[0]\t$tab[5]\t$tab[6]\t$tab[7]\t$tab[12]\t$tab[14]\t$tab[19]\n";

  }
close(IN);
