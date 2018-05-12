#!/bin/perl

# using a fasta multiple alignment write each sequence onto one line
# note see pir2fasta.scr to convertmultiple alignment in PIR format to fasta multiple alignment
 
#use: more inputAlignent_file | multalign2oneline.pl > outputfile
$i=0;
while(<>)
{   if ( m/>/ && $i > 0 ) { print "\n"; }
    if ( m/>/ ) { print $_;}
    if ( !m/>/ ) { chop; print $_; }
    $i++;
}
