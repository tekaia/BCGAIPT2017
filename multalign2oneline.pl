#!/bin/perl

# using a fasta multiple alignment write each sequence onto one line sequence
# or fasta database of sequences write each sequence onto one line sequence
$i=0;
while(<>)
{   if ( m/>/ && $i > 0 ) { print "\n"; }
    if ( m/>/ ) { print $_;}
    if ( !m/>/ ) { chop; print $_; }
    $i++;
}
