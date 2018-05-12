#!/usr/bin/perl

#compute the base composition of a fasta formatted dna sequence
#Use: basecomp.pl input_sequence.dna (seq)
#Output file is input_sequence.BASEcomp

$IN=@ARGV[0]; # input file

$out = $IN;
$out =~ s/\.//g;
$OUT="$out".".BASEcomp";

open(IN,"$IN") || die "cannot open $IN\n";
open(OUT,">$OUT");
while(<IN>)
{
    if (!m/>/ )
    {
    @tab=split('', $_);

    foreach $j ( 0 .. $#tab-1)
    {
	$base{$tab[$j]}++;
    }#foreach

    }# if m
}#while IN
close(IN);

$tot = $base{A} + $base{C} + $base{T} + $base{G};
$Xp = ($base{A}*100)/$tot;
       @V  = split(/[\.]/, $Xp);
       $d  = substr($V[1],0,2);
       $Ap = "$V[0]".".$d";

$Xp = ($base{C}*100)/$tot;
       @V  = split(/[\.]/, $Xp);
       $d  = substr($V[1],0,2);
       $Cp = "$V[0]".".$d";

$Xp = ($base{T}*100)/$tot;
       @V  = split(/[\.]/, $Xp);
       $d  = substr($V[1],0,2);
       $Tp = "$V[0]".".$d";

$Xp = ($base{G}*100)/$tot;
       @V  = split(/[\.]/, $Xp);
       $d  = substr($V[1],0,2);
       $Gp = "$V[0]".".$d";

$GCp = $Gp + $Cp;

print OUT "Spec/seq\tA\tC\tT\tG\tGC%\tTot\n";
print OUT $IN;
print OUT "\t$Ap\t$Cp\t$Tp\t$Gp\t$GCp\t$tot\n";


close(OUT);
