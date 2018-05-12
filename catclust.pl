#!/bin/perl

#cat protein sequences corresponding to members of an ORTH cluster
#Use catclust.pl
#Outfile is : Cluster.pep (exp. Cn.m.pep or Cn.m-Cp.q.pep )

$IN=@ARGV[0]; # sfamXX-PMCL file

open(IN,"$IN") || die "can't open $IN";
while(<IN>)
{
    @tab=split(/\s+/, $_);

#    sequence identifications are assumed to be preceeded by their species code
# note the importance of starting by inserting the species code after the ">" in the species database
# before blast formatting and splitting this file into individual sequences
    if ( $tab[0] =~ SACE )  {  system(`cat $path/allsaceprt.fasta/$tab[0].prt >> FAMSEQ/$tab[1].pep`); }
    if ( $tab[0] =~ CAGL )  {  system(`cat $path/allcaglprt.fasta/$tab[0].prt >> FAMSEQ/$tab[1].pep`); }
    if ( $tab[0] =~ ZYRO )  {  system(`cat $path/allzyroprt.fasta/$tab[0].prt >> FAMSEQ/$tab[1].pep`); }
}
close(IN);
