#!/usr/bin/perl

# transform allxxnum.HS into cmi format (see mcl user guide)
#data are supposed to be sorted according to the 3rd position.
#use all2cmi.pl allxxnum.HS xx.tab > allxxnum.cmi (see mcl user guide).

$A=@ARGV[0]; # file allxxnum.HS
$IND=@ARGV[1]; # index file (num ORFname)

if ( length(@ARGV[1])  <2 ) 
{ print"\nUsage: mclall2cmi.pl allxxnum  XX.tab > allxxnum.cmi\n\n"; exit; }

$OUT="$A".".cmi";
open (OUT, ">$OUT"); #output file
#last line of xx.tab
$DIM is the largest idex number
    @TAB=split(/\s+/,`tail -1 $IND`);
    $DIM=$TAB[0];

$DIM++;

print OUT  "(mclheader\n";
print OUT "mcltype matrix\n";
print OUT "dimensions $DIM"; print OUT "x"; print OUT "$DIM\n";
print OUT ")\n";
print OUT "(mclmatrix\n";
print OUT "begin\n";

$iflag=0;
$PSEQ=-1;
$K=0;
open(A,"$A") || die "can't open $A";
while(<A>)
{
    @tab=split(/\s+/, $_);
    $I=$tab[0];
    $J=$tab[2];
    $S=$tab[5];

###probleme du $ en fin de ligne!

    if ( $I eq $PSEQ && eval($lig%4) == 0 ) { print OUT "\n";}
    if ( $K == 0 ) {  print OUT "$I"; $lig=0; }
    if ( $I ne $PSEQ && eval($lig%4) == 0 && $K > 0 ) { print OUT " \$"; print OUT "\n"; print OUT "$I"; $lig=0; }
    if ( $I ne $PSEQ && eval($lig%4) != 0 ) { print OUT " \$"; print OUT "\n"; print OUT "$I"; $lig=0; }

    print OUT "  $J"; print OUT ":"; print OUT $S; $lig++; 

    $PSEQ=$tab[0];
    $K++;
}#while A

print OUT " \$";
print OUT "\n ) ";
close(A);
close (OUT);
