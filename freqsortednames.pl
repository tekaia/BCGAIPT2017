#!/bin/perl

#computes frequencies of one column sorted words or numbers

#IN should include sorted words or numbers
# output distinct words (or numbers) and corresponding frequencies
#use freqsortednames.pl nomorf &
#output $IN.freq

$IN=@ARGV[0]; # sorted one column file names

$NOMP="";
$i=0;
open (IN,"$IN") || die "cant open $IN";
$OUT="$IN".".freq";
if ( -e $OUT ) { `rm $OUT`; }
open(OUT,">>$OUT");
while(<IN>)
{
    @tab=split(/\s+/, $_);
    if ( $tab[0] ne $NOMP && $i > 0 ) { print OUT "$NOMP\t$n\n"; $n=0; }
    $NOMP=$tab[0];
    $n++;
    $i++;

    $P=$tab[0];
}
print  OUT "$NOMP\t$n\n";
