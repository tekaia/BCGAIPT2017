#!/usr/bin/perl

#extract individual mcl clusters and write each in individual file including its members
#Usage: extractmclcluster.pl XX.mclclusters
#Results should be in a subdirectory families (mkdir families)
#Each cluster is denoted Cn.m.mcl and includes in the first line Cn then in each of the following line:
#ORF, size of the cluster and the cluster identification (Cn.m).

$IN=@ARGV[0];   #input file  is XX.mclclusters
if ($IN eq "") { die "Usage: extractmclcluster.pl XX.mclclusters\n\n";}

$P="";  #previous cluster on the previous line
open (IN, "$IN");
while(<IN>)
{
  @tab=split(/\s+/, $_);

  if ($tab[0] ne $P )
     {
     close (OUT);
     $OUT="$tab[0]".".mcl";

     open (OUT, ">$OUT");
     $Cn=$tab[0];
     $Cn =~ s/\..*//g;
	     print OUT "$Cn\n";
     }#if $tab  

  @tab=split(/\s+/, $_);
  print OUT "$tab[2]\t$tab[1]\t$tab[0]\n";
  $P= $tab[0];

}#while
