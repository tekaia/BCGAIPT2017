#!/usr/bin/perl

#amino acids composition and size of each sequence in a fasta formatted protein sequences database
#Example of use: aacontent.pl GSACE.pep > GSACE.aacomp

@AA = ('A', 'R', 'N', 'D', 'C','Q', 'E', 'G', 'H', 'I', 'L', 'K', 'M', 'F', 'P', 'S', 'T', 'W', 'Y', 'V', 'B');

$IN=@ARGV[0];
open(IN,"$IN");

print "Seqname";
foreach $aa ( 0 .. $#AA) { print "\t$AA[$aa]"; }
print "\tsize\n";

$i=0;

while (<IN>)
{

    if ( m/>/ && $i == 0 ) {  @tab = split(/\s+/, $_); $tab[0] =~ s/>//g; $seqnamep = $tab[0];   $i++; next;  }

    if (m/>/ ) 
    {

      print "$seqnamep"; 

      foreach $aa ( 0 .. $#AA ) { print "\t$count{$AA[$aa]}"; $size = $size + $count{$AA[$aa]} ; $count{$AA[$aa]}=0; }
      print "\t$size\n"; $size = 0;


      @tab = split(/\s+/, $_);
      $tab[0] =~ s/>//g;
      $seqnamep = $tab[0];

    }#if m

if ( !m/>/)
{
    @tab=split('', $_);
    foreach $j ( 0 .. $#tab-1) 
      { 
      $count{$tab[$j]}++; 
      }#foreach $j
    
}#if !m


}#while

#print " Last$sequence";
print "$seqnamep";
foreach $aa ( 0 .. $#AA ) { print "\t$count{$AA[$aa]}"; $size=$size+$count{$tab[$j]}; }
print "\t$size\n";
