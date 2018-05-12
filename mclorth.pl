#!/usr/bin/perl

#mcl clustering of orthologs
#use mclpar.pl alltotorth

$IN = @ARGV[0];

$PATH to directory
    $PD  = "/home0/genanal/genomes/RBH";
    $MCL = $PD."/"."MCL";
#create the directory MCL
    system("mkdir $MCL");
    system("cd $MCL");

#working directory RBH
    system('cat alltotorth | nom.pl > temp');
    system("freqsortednames.pl temp");
    system("mv temp.freq freqtotorth.freq");
    system("sort -n -k 2 -r freqtotorth.freq | nom.pl > nomorf");

#list of sequence identifier nomorf
    system("cd $MCL");
    system("ln -s ../alltotorth");
    system("mv ../nomorf $MCL ");
#mcl scripts
    system("mcltabform.pl nomorf > ORTH.tab");
    system("mclall2num.pl ORTH.tab alltotorth > allorthnum");
    system("mclall2cmi.pl allorthnum ORTH.tab");  (output allorthnum.cmi)
#   (output allorthnum.cmi )

#run the mcl program with inflation index -i 3.0 and output file -o $GEN.clusters
    system("mcl allorthum.cmi -i 3.0  -o ORTH.clusters");  (output mcl clustering)
#run mcltribefamilies.pl 
    system("mcltribefamilies.pl ORTH.clusters ORTH.tab > ORTH.clusters-tribe");
#reformat the clusters:Cn.m<tab>n<tab>ORF identification 
#(C: cluster, n is the number of elements in the cluster and m an arbitrary index order.)
    system("mclclustsize.pl ORTH.clusters-tribe > ORTH.mclclusters");

#renumber classes in increasing order for each size (ie m values in increasing order starting from 1 for each size).
    system("renumclass.pl ORTH.mclclusters");

#Histogram of cluster contents: compute how many clusters are constructed for each cluster size compute.
    system('more ORTH.mclclusters | nom.pl | sort –u | sed –e “s/\..*//g” –e “s/C//g” | sort –n > temp');
    system('sed –e “s/^/C/g” temp.freq > ORTH-mclclusters.histo');

#Extract from ORTH.mclclusters each cluster and its corresponding members.
#create a directory mclfamilies
    system("mkdir mclorthfamilies");
    system("cd mclorthfamilies");
    system("extractmclcluster.pl ../ORTH.mclclusters");
#outputs: Cn.m.mcl file: with the first line Cn, then for each line: ORF <tab>cluster_size<tab>mcl_cluster

# nomorth.mclorth file corresponding to cluster of hortologs: orf_ident <tab<  mclcluster (Cn.m)
    system("identmclorth.pl nomorf ORTH.mclclusters");



