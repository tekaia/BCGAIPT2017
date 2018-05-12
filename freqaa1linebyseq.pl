#!/usr/bin/perl

#compute aa content and size of fasta formatted protein sequences dbfile
#Use freqaa1linebyseq.pl dbfile.pep &
#outfile is dbfile.freqaa

$IN=@ARGV[0];

$out = $IN;
$out =~ s/\.//g;

$OUT = "$out".".freqaa";

@AA = ('A','R','N','D','C','Q','E','G','H','I','L','K','M','F','P','S','T','W','Y','V');
$naa=19;

open(IN, $IN);
open(OUT,">$OUT");

print OUT $IN;
for $j ( 0 .. $naa ) { print OUT "\t$AA[$j]"; }
print OUT "\ttotaa\n";

$i=0;
while(<IN>)
{
    if ($i == 0 && m/^>/ ) {@tab=split(/\s+/, $_); $seqid = substr($tab[0], 1, length($tab[0])); }

 if ( m/^>/ && $i > 0 )
 {

     $seqidP=$seqid;

     for $j ( 0 .. $naa) { $totaa = $totaa + $FAA[$j]; }

     for $j ( 0 .. $naa)
     {
     $FAAp[$j] = $FAA[$j]*100/$totaa;
     @p=split(/[\.]/, $FAAp[$j]);
     $d=substr($p[1],0,2);
     $FAAp[$j] = "$p[0]".".$d";
     }#for $j

     print OUT $seqidP;
     for $j ( 0 .. $naa) { print OUT "\t$FAAp[$j]"; }
     print OUT "\t$totaa\n";

     @tab=split(/\s+/, $_);
     $seqid = substr($tab[0], 1, length($tab[0]));
     
      for $j ( 0 .. $naa) { $FAA[$j] = 0; }
     $totaa=0;

 }# if m/>

 if ( !m/>/ )
 {
#put everything uppercase
      $_ =~ tr/a-z/A-Z/; 

#count each aa per line
      @tab=split('', $_);
         foreach $j ( 0 .. $#tab-1)
         {
	 $base{$tab[$j]}++;
         }#foreach

         foreach $j ( 0 .. $naa)
         {
	     $FAA[$j] = $base{$AA[$j]};
	 }

}#if m
    $i++;
}#while IN
close(IN);

     for $j ( 0 .. $naa) { $totaa = $totaa + $FAA[$j]; }

     for $j ( 0 .. $naa)
       {
       $FAAp[$j] = $FAA[$j]*100/$totaa;
       @p=split(/[\.]/, $FAAp[$j]);
       $d=substr($p[1],0,2);
       $FAAp[$j] = "$p[0]".".$d";
       }#for $j                                                                                                        
print OUT $seqid;

for $j ( 0 .. $naa) { print OUT "\t$FAAp[$j]"; }
print OUT "\t$totaa\n";
