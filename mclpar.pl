#!/usr/bin/perl

#create for each ORF identification its corresponding cluster of paralogs "Cn.m" or "single" if uniq.
#Use mclpar.pl SACE.ident SACE.mclclusters > SACE.mclpar &

$IN = @ARGV[0]; #identification of ORFs species.ident
$CLUST = @ARGV[1]; #species.mclclusters file

open(IN, "$IN");
while(<IN>)
{

    @tab=split(/\s+/, $_);
    $C="Single";
    @LINE=split(/\s+/, `grep -w $tab[0] $CLUST`);

    if ( $LINE[2] )
    {
	$C = $LINE[0];
    }#if length
	print "$tab[0]\t$C\n";

}#while IN
close(IN);
