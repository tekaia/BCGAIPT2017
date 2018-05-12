#!/usr/bin/perl

#extract data tables corresponding for a given domain to WGS: Complete, Incomplete or to Permanent Draft
#and Transcriptom: Comple or incomplete
#Use stats.pl &
#Domain is Archaea, Bacteria, Eukaryotes or Viruses
#final outfile StatisticsgoldData.txt

@DOMAIN = ( "Archaea" , "Bacteria" , "Eukaryotes" , "Viruses" ) ;

foreach $j ( 0 .. 3)
{ 
        $DOM=$DOMAIN[$j];

$OUTWC="$DOM"."_WGS_Complete.tab";
$OUTWI="$DOM"."_WGS_Incomplete.tab";
$OUTWP="$DOM"."_WGS_Permanent_Draft.tab";

$OUTTC="$DOM"."_Transcriptome_Complete.tab";
$OUTTI="$DOM"."_Transcriptome_Incomplete.tab";

open(OUTWC,">$OUTWC");
open(OUTWI,">$OUTWI");
open(OUTWP,">$OUTWP");
open(OUTTC,">$OUTTC");
open(OUTTI,">$OUTTI");

$i=0;
open (IN,"$DOM.tab");
while(<IN>)
{
    @tab=split(/[\t]/,$_);
    print OUTWC $_ if ( $i == 0 );
    print OUTWI $_ if ( $i == 0 );
    print OUTWP $_ if ( $i == 0 );
    print OUTTC $_ if ( $i == 0 );
    print OUTTI $_ if ( $i == 0 );

    $i++;

 print OUTWC $_ if (($tab[1] eq "Whole_Genome_Sequencing" || $tab[1] eq "Resequencing" ) && ($tab[2] eq "Complete_and_Published" || $tab[2] eq "complete" ));
 print OUTWI $_ if ($tab[1] eq "Whole_Genome_Sequencing" && $tab[2] eq "incomplete");                                                                          
 print OUTWP $_ if ($tab[1] eq "Whole_Genome_Sequencing" && $tab[2] eq "Permanent_Draft");                                                                     

 print OUTTC $_ if ($tab[1] eq "Transcriptome" && ($tab[2] eq "Complete_and_Published" || $tab[2] eq "complete" ) );                                           
 print OUTTI $_ if ($tab[1] eq "Transcriptome" && ($tab[2] eq "incomplete" || $tab[2] eq "Permanent_Draft" ));

}#while IN
close(IN);
close(OUTWC);close(OUTWI);close(OUTWP);close(OUTTC);close(OUTTI);

} #foreach

$OUT="StatisticsgoldData.txt";
open(OUT,">$OUT");
print OUT "Statistics on genome sequencing projects (goldData.txt):\n\n";
#Print statistics

@FILES = ("_WGS_Complete.tab", "_WGS_Incomplete.tab", "_WGS_Permanent_Draft.tab", "_Transcriptome_Complete.tab", "_Transcriptome_Incomplete.tab");

$OUTWC="$DOM"."_WGS_Complete.tab";
$OUTWI="$DOM"."_WGS_Incomplete.tab";
$OUTWP="$DOM"."_WGS_Permanent_Draft.tab";

$OUTTC="$DOM"."_Transcriptome_Complete.tab";
$OUTTI="$DOM"."_Transcriptome_Incomplete.tab";

foreach $i ( 0 .. 4)
{
    $file=$FILES[$i];

    if ( $file eq "_WGS_Complete.tab"             ) { print OUT "Completely sequences genomes:\n";  }
    if ( $file eq "_WGS_Incomplete.tab"           ) { print OUT "\nIncompletely sequenced genomes (or in progress):\n"; }
    if ( $file eq "_WGS_Permanent_Draft.tab"      ) { print OUT "\nPermanent Draft:\n"; }
    if ( $file eq "_Transcriptome_Complete.tab"   ) { print OUT "\nTranscriptome complete:\n"; }
    if ( $file eq "_Transcriptome_Incomplete.tab" ) { print OUT "\nTranscriptome incomplete (or in progress):\n"; }

    $tot=0;
    foreach $j ( 0.. 2)
    {
    $DOM  = $DOMAIN[$j];
    $FILE = "$DOM"."$file";

        system(`cat $FILE | wc -l > temp`);
        open(T, "temp");                                                                                                                                         
         while(<T>)
         { @tab=split(/\s+/, $_);
           $tab[1]= $tab[1]-1;
           print OUT "$DOM\t$tab[1]\n";
           $tot=$tot+$tab[1];
         }#while T 
    system("rm temp"); 

    }# foreach $j
        print OUT "Total\t$tot\n";      

#Viruses            

    $j=3;
    $DOM=$DOMAIN[$j];
    $FILE = "$DOM"."$file";

    system(`cat $FILE | wc -l > temp`);
    open(T, "temp");
         while(<T>)
         { @tab=split(/\s+/, $_);
         $tab[1]= $tab[1]-1;
         print OUT "\n$DOM\t$tab[1]\n";
         }#while T 
         system("rm temp");                            

}#foreach $i
