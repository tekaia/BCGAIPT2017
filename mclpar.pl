#!/usr/bin/perl

#mcl clustering of non-unique proteins in each species
#use mclpar.pl genomelist
#where genomelist includes species coding

$IN = @ARGV[0];
open(IN, "$IN");
while(<IN>)
{
    @tab=split(/\s+/, $_);
    $GEN = $tab[0];
    $gen = $GEN;
    $gen =~ tr/A-Z/a-z/;

$PATH to directory
    $PD  = "/home0/genanal/genomes";
    $DIR = $PD."/".$GEN;
    $DIRO= $DIR."/".$GEN."seqnew";
    $MCL = $DIRO."/"."MCL";
#create the directory MCL
    system("mkdir $MCL");

#working directory $DIRO
    system('cat all$gen$genseqnew.HS | nom.pl > temp');
    system("freqsortednames.pl temp");
    system("mv temp.freq $GEN.freq");
    system("cat $GEN.freq | nom.pl > nomorf");

#list of sequence identifier nomorf
    system("cd $MCL");
    system("ln -s ../all$gen$genseqnew.HS");
    system("mv ../nomorf $MCL ");
#mcl scripts
    system("mcltabform.pl nomorf > $GEN.tab");
    system("mclall2num.pl $GEN.tab all$genseqnew.HS > all$gennum");
    system("mclall2cmi.pl all$gennum $GEN.tab");
#   (output all$gennum.cmi )

#run the mcl program with inflation index -i 3.0 and output file -o $GEN.clusters
    system("mcl all$gennum.cmi -i 3.0  -o $GEN.clusters");
#run mcltribefamilies.pl 
    system("mcltribefamilies.pl $GEN.clusters $GEN.tab > $GEN.clusters-tribe");
#reformat the clusters:Cn.m<tab>n<tab>ORF identification 
#(C: cluster, n is the number of elements in the cluster and m an arbitrary index order.)
    system("mclclustsize.pl $GEN.clusters-tribe > $GEN.mclclusters");

#renumber classes in increasing order for each size (ie m values in increasing order starting from 1 for each size).
    system("renumclass.pl $GEN.mclclusters");

#Histogram of cluster contents: compute how many clusters are constructed for each cluster size compute.
    system('more $GEN.mclclusters | nom.pl | sort –u | sed –e “s/\..*//g” –e “s/C//g” | sort –n > temp');
    system('sed –e “s/^/C/g” temp.freq > $GEN-mclclusters.histo');

#Extract from SACE.mclclusters each cluster and its corresponding members.
#create a directory mclfamilies
    system("mkdir mclfamilies");
    system("cd mclfamilies");
    system("extractmclcluster.pl ../$GEN.mclclusters");
#outputs: Cn.m.mcl file: with the first line Cn, then for each line: ORF <tab>cluster_size<tab>mcl_cluster

# $GEN.mclpar file corresponding to cluster of paralogs: orf_ident <tab<  mclcluster (Cp.q or single)
    system("identmclpar.pl $GEN.ident $GEN.mclclusters");


}#while IN
