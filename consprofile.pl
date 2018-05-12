#!/usr/bin/perl
#usage consprofile.pl SACE CAGL ZYRO
#      .........      CAGL SACE ZYRO
#                     ZYRO SACE CAGL
#output files: species_ConsProf including for each sequence its hits (if any) and species_ConsProf01
# including for each sequences the corresponding 0, 1 profile.

#$IDENT=@ARGV[0];
$SPEC1=@ARGV[0];
$SPEC2=@ARGV[1];
$SPEC3=@ARGV[2];

$temp = $SPEC1;
$temp =~ tr/A-Z/a-z/;
$spec1 = $temp;

$temp = $SPEC2;
$temp =~ tr/A-Z/a-z/;
$spec2 = $temp;

$temp = $SPEC3;
$temp =~ tr/A-Z/a-z/;
$spec3 = $temp;

#intra-species reciprocal best hits
$S="$spec1"."$spec1".".rbh";
open(S, "$S");
while (<S>)
{
    @tab=split(/\s+/, $_);
    $H1{$tab[0]}=$tab[1];

}#while S
close (S);

#inter-species reciprocal best hits
$C="$spec1"."$spec2".".rbh";
open(C, "$C");
while (<C>)
{
    @tab=split(/\s+/, $_);
    $H2{$tab[0]}=$tab[1];

}#while C
close (C);

#inter-species reciprocal best hits
$Z="$spec1"."$spec3".".rbh";
open(Z, "$Z");
while (<Z>)
{
    @tab=split(/\s+/, $_);
    $H3{$tab[0]}=$tab[1];

}#while Z
close (Z);

$OUT="$SPEC1"."_ConsProf";
$OUT01="$OUT"."01";
open (OUT, ">$OUT");
open (OUT01, ">$OUT01");

$IDENT="$SPEC1".".ident"; 
open(I, "$IDENT");
while (<I>)
{
    @tab=split(/\s+/, $_);
    
    $v1=$v2=$v3=0;
    if ($H1{$tab[0]}) {$v1=$H1{$tab[0]};}  
    if ($H2{$tab[0]}) {$v2=$H2{$tab[0]};}
    if ($H3{$tab[0]}) {$v3=$H3{$tab[0]};}
    
    if ($SPEC1 eq "SACE") { print OUT "$tab[0]\t$v1\t$v2\t$v3\n";}
    if ($SPEC1 eq "CAGL") { print OUT "$tab[0]\t$v2\t$v1\t$v3\n";}
    if ($SPEC1 eq "ZYRO") { print OUT "$tab[0]\t$v2\t$v3\t$v1\n";}
    
  #  print OUT01 "$tab[0]\t";
    $V1=$V2=$V3=0;
    if ($H1{$tab[0]}) {$V1=1;}  
    if ($H2{$tab[0]}) {$V2=1;}
    if ($H3{$tab[0]}) {$V3=1;}

    if ($SPEC1 eq "SACE") { print OUT01 "$tab[0]\t$V1\t$V2\t$V3\n";}
    if ($SPEC1 eq "CAGL") { print OUT01 "$tab[0]\t$V2\t$V1\t$V3\n";}
    if ($SPEC1 eq "ZYRO") { print OUT01 "$tab[0]\t$V2\t$V3\t$V1\n";}
}#while 
close (I);
close (OUT);
close (OUT01);
