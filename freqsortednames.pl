#!/usr/bin/perl

#computes frequencies of one column sorted names

#IN should include sorted names
# output distinct names and corresponding frequencies
# useful for huge sorted file names as in orthologs
#use freqsortednames.pl nomorftot &
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

}

print  OUT "$NOMP\t$n\n";
