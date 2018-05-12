#!/usr/bin/perl

#compute the base composition of a fasta formatted dna sequence
#Use: basecontent.pl input_sequence.dna
#Output file is input_sequence.dna.BASEcontent

$IN=@ARGV[0]; # input file
$OUT="$IN".".BASEcontent";

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

print "A\t$base{A}\n";
print "C\t$base{C}\n";
print "T\t$base{T}\n";
print "G\t$base{G}\n";


#----- note: output  using keys
print "keys test\n";
foreach $id ( keys %base )
{
print OUT "$id\t$base{$id}\n"
}
