#!/usr/bin/perl


#script to prepare tab formatted RF Identifications in use with mclall2nul mcl script
#Use mcltabform.pl nomorf > speciesname.tab

$IN=@ARGV[0];   # file containing ORF identifications in alphabetical order

$i=0;
open(IN,"$IN") || "die can't open $IN";
print "#<mapped index> <tag>\n";
print "# sort mode is alphabetical\n";
while(<IN>)
{
    print "$i $_";
    $i++;
}
