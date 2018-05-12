#!/usr/bin/perl

#check for HS reciprocity in allxxyy.HS file
#remove non RBH sequences
#Use reciprocHS.pl allxxyy.HS > temp
#mv temp allxxyy.HS

$IN=@ARGV[0];

open(IN,"$IN");
while(<IN>)
{

    @tab=split(/\s+/, $_);

    print $_ if (`grep -w $tab[0] $IN | grep -w $tab[1]`);

}
