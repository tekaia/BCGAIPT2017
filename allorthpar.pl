#!/usr/bin/perl
#usage: allorthpar.pl nomorth.mclorth &
#output file allorth-mcl: ORF_ident <tab> Cn.m <tab> Cp.q <tab> Cn.m-Cp.q  (Cn.m: orthologs cluster; Cp.q: paralogs cluster or single).

#working directory is MCL
$PD="/home0/genanal/genomes";

$ORTH=@ARGV[0];  # orf_ident <tab> Cn.m (cluster)

$OUT="sfamorth-mcl";
open (OUT, ">$OUT");
open(ORTH,"$ORTH");
while(<ORTH>)
{
    @tab=split(/\s+/, $_);

    $SPEC =  $tab[2];
    $SPEC =~ s/_.*//g;

#$SPEC.mclpar (orf_ident <tab> Cp.q/Single)
    $DIR = "$PD/$SPEC/$SPECseqnew/MCL";
    system("grep -w $tab[2] $DIR/$SPEC.mclpar > temp");

    open(T, "temp");
    while<T>)
    {
	@TAB  = split (/\s+/, $_);
        $sfam = "$tab[1]-$TAB[1]";
#output: orf_ident <tab> Cn.m (orth clust) <tab> Cp.q (paralog clust)
        print OUT "$tab[0]\t$tab[1]\t$TAB[1]\t$sham\n";
    }#while T
    close(T);

}#ORTH
close(ORTH);
close(OUT);
