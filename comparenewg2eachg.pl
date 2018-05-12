#!/usr/bin/perl

#compares a new genome $GEN versus each of the proteomes
# in "genomeslist" using blastp with blosum62 and SEG filter

#Use comparenewg2eachg.pl MYTU genomeslist (MYTU is the new genome, genomeslist includes a liste of species codes)
# genome is the organism code in upper case letter
# MYTU/MYTUseqnew, MYTU/MYBOseqnew etc... will be created
#genomelist includes genomes codes in upper case letters

$GEN     = @ARGV[0];  #new genome code
$GENLIST = @ARGV[1];  #List of genome codes
$O       = @ARGV[2];  # save blastp output file y/n

   if ( $GEN eq "" || $GEN eq "-h" || $GENLIST eq "" ) 
      { print "\nUsage: comparenewg2eachg.pl genome_code genome_list_file y/n\n\n";
        exit(0);
      }

if ( $O ne "y" && $O ne "Y" && $O ne "n" && $O ne "N" ) 
{ print "Usage:\n";
  print " comparenewg2eachg.pl genome_code genome_list_file y/n\n\n";
  print " Save blast output Yes=Y\y, No=N\n\n"; 
  exit(0);
}

$temp=$GEN;
$temp =~ tr/A-Z/a-z/;
$gen=$temp;

$O =~ tr/A-Z/a-z/;

#Path directory should be adapted for local use
$PD="~/home0/genanal/genomes";

#create the directory
$DIR=$PD."/".$GEN;
#print "DIR=$DIR\n";
unless (-e $DIR) { system ("mkdir $DIR")};

open(GL, "$GENLIST") || "die can't open genomeslist file";
$OUT=$PD."/".$GEN.".report";  # file report for comparisons done
open(OUT,">>$OUT");
system ("date >> $OUT");
DEB: while(<GL>)
{
    @tab=split(/\s+/, $_);

#translate the genome code in upper $G1 and lower $g1 cases
    $G1  = $tab[0];
    $temp=$G1;
    $temp  =~ tr/A-Z/a-z/;
    $g1 = $temp;

#database is of the form: GXXXX.pep, GXXXX.dna,...
    $DB="G".$G1.".pep";

    $DIRO=$DIR."/".$G1."seqnew";
    print OUT "DIRO=$DIRO\n";

    if ( -e $DIRO ) 
    { print OUT "--> $DIRO exists (skipped)\n"; next DEB; } # next if $DIRO exists
    unless (-e $DIRO) {
       system ("mkdir $DIRO");
                      }#unless
 system("blastallgenomes.scr $DB $G1 $g1 $GEN $gen blosum62 blp $O");

       print OUT "blastallgenomes.scr $DB $G1 $g1 $GEN $gen blosum62 blastp $O\n";
       print OUT "done\n\n";                      
 

}#while GL

