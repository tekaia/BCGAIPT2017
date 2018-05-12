#!/bin/perl

#cat protein sequences corresponding to members of an ORTH cluster
#Use catclustorth.pl sfamorth-mcl &
#Outfile is : Cluster.pep (exp. Cn.m.pep or Cn.m-Cp.q.pep )

#working directory is RBH/MCL
$IN=@ARGV[0]; # sfamORTH-MCL file

$PD="/home0/genanal/genomes";
$DIR="$PD/RBH/MCL";

$DIRD="/home0/data";
unless ( -e "FAMSEQ" ) { system "mkdir FAMSEQ" };

system("cd $DIR");

open(IN,"$IN") || die "can't open $IN";
while(<IN>)
{
    @tab=split(/\s+/, $_);

#    sequence identifications are assumed to be preceeded by their species code
# note the importance of starting by inserting the species code after the ">" in the species database
# before blast formatting and splitting this file into individual sequences

    $SPEC =  $tab[0];
    $SPEC =~ s/_.*//g;
    $spec = $SPEC;
    $spec =~ tr/A-Z/a-z/;

    system("cat $DIRD/all$specprt.fasta/$tab[0].prt >> FAMSEQ/$tab[1].pep");

}
close(IN);
