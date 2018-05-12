#!/usr/bin/perl

#extract sub-tables from goldDatafinal.txt corresponding to each of the phylogentic Domains: BACTERIAL, ARCHAEAL, EUKARYAL and VIRUS.
#use extractDomain.pl
#Output files: Bacteria.tab, Archaea.tab, Eukaryotes.tab and Viruses.tab.

open(IN,"goldDatafinal.txt");
open(OUTA,">Archaea.tab");
open(OUTB,">Bacteria.tab");
open(OUTE,">Eukaryotes.tab");
open(OUTV,">Viruses.tab");

$i=0;
while(<IN>)
  {
print OUT $_ if ( $i == 0 );
@tab=split(/[\t]/,$_);

if ( $tab[4] eq "ARCHAEAL"  )  {print OUTA $_  };
if ( $tab[4] eq "BACTERIAL" )  {print OUTB $_  };
if ( $tab[4] eq "EUKARYAL"  )  {print OUTE $_  };
if ( $tab[4] eq "VIRUS"     )  {print OUTV $_  };

$i++;
  }
close(IN); close(OUTA); close(OUTB); close(OUTE); close(OUTV);

