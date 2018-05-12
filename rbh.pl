#!/usr/bin/perl

# Reciprocal Best Hits (rbh), input1: bestxxyy.HS, input2: bestyyxx.HS
#usage: rbh.pl bestxxyy.HS bestyyxx.HS &
# output: xxyy.rbh

$B1=@ARGV[0]; # bestxxyy.HS
$B2=@ARGV[1]; # bestyyxx.HS

$out=$B1;
$out =~ s/best//g;
$out =~ s/\.HS//g;
$OUT=$out.".rbh";

open (OUT, ">$OUT");
open (B1, "$B1");
while (<B1>)
{
    @tab=split(/\s+/, $_);
    $BEST1{$tab[0]}= $tab[1];
}#while B1
close (B1);

open (B2, "$B2");
while (<B2>)
{
    @tab=split(/\s+/, $_);
    if ($BEST1{$tab[1]} eq $tab[0]) {print OUT "$tab[1]\t$tab[0]\n";}
}#while B2
close (B2);
