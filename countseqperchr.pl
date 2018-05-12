#!/usr/bin/perl

#count the number of sequences per chromosome in a fasta formatted yeast GSACE.pep or GSCE.dna
#note that in this file the chromosome identifier is at the second position of the sequence identifier

#note that in GCAGL.pep, GCAGL.dna, GZYRO.pep and GZYRO.dna the chromosome identifier is
#position 6 of the sequence identifier

#use countseqperchr.pl GSACE.pep &
#output file: GSACEpepseqperchr.tab

$IN=@ARGV[0]; 
open(IN,"$IN");

### remove the dot in $IN
$in = $IN;
$in =~ s/\.//g;
$OUT="$in"."seqperchr.tab";
open (OUT, ">$OUT");

print OUT "CHR\t#seq\n";

while(<IN>)
{

if ( m/^>/ )
   {
    @tab=split(/\s+/,$_);
    if ( $tab[0] =~ /^>Y/ ) { $chr=substr($tab[0], 2, 1); } 
    if ( $tab[0] =~ /^>CAGL/ || $tab[0] =~ /^>ZYRO/ ) { $chr=substr($tab[0], 6, 1); }
    $CHR{$chr}++;
   }#if m
   
}#while
close(IN);

#print results
foreach $k (keys %CHR)
{
    print OUT "$k\t$CHR{$k}\n";
}

close OUT;
