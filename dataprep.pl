#!/usr/bin/pl

# data preparation for genome comparisons
#use: dataprep.pl genomelist&
#where genomelist includes species codes for which proteomes are to be compared and analysed
#working directory is ~/home0/data/

$IN=@ARGV[0];
while(<IN>)
{
 @tab=split(/\s+/, $_);

$SPEC = $tab[0];
$spec =~ tr/A-Z/a-z/;

#recode the sequence identification by inserting the species code
system('sed -e "s/>/>$SPEC_/g" G$SPEC.pep > temp');
system('mv temp G$SPEC.pep');

#extract sequence identifiers and redirect in $SPEC.ident ($PR/$SPEC/$SPECseqnew/)
$PR="/home0/genanal/genomes"  # path to genomes
$DIRRES="$PR/$SPEC/$SPECseqnew";
system('grep ">" ~/home0/data/G$SPEC.pep | nom.pl | sed -e "s/>//g" > $DIRES/$SPEC.ident');

#create the allxxprt.fasta directory and split the database into individual sequences
$DIRPRT = "all"."$spec"."prt".".fasta";
system('mkdir $DIRPRT');
system("splitfasta.pl G$SPEC.pep > $DIRPRT");

#make blast db
system("makeblastdb  -title «$SPEC proteome» –in  G$SPEC.pep –dbtype prot");

}#while IN
