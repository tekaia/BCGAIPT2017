#!/usr/bin/perl

# add the cluster size (number of protein in the cluster mcl_cluster 
#use mclclustsize.pl test.clusters_tribe > test.mclclusters
#output file includes for each ORF,  the following columns: Cn.m, n, ORF, where C (stands for cluster, n is 
# the number of ORFs in the cluster and m is an arbitrary index order for the clusters). 

$IN=@ARGV[0]; # file of cluster as obtaines by tribe_families.

system(`cat $IN | nom.pl | sort -n -u > NN`);

open (I , "NN" ) || die "can't open NN ";
while(<I>)
{
    @tab=split(/\s+/, $_ );

system(`grep -w "^$tab[0]" $IN > TEMP`);

        @NTAB=split(/\s+/, `cat TEMP | wc -l`);
	$size=$NTAB[0];

    open(T, "TEMP") || die "can't open TEMP";
    while(<T>)
    {
	@TAB=split(/\s+/, $_ );
	print "C$size."; print "$TAB[0]\t$size\t$TAB[1]\n";
    }
    close(T);

}
close(I);
system("rm TEMP NN ");
