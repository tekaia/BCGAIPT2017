#!/usr/bin/perl

#compute base content, GC% and size of fasta formatted sequences dbfile
#Use freqnt1line.pl dbfile.dna or dbfile.seq

$IN=@ARGV[0];

open(IN, $IN);
while(<IN>)
{

 if ( !m/>/ )
 {
#put everything uppercase
     $Line = $_ =~ tr/a-z/A-Z/; 
#count each base perline

      @tab=split('', $_);
        foreach $j ( 0 .. $#tab-1)
        {
	$base{$tab[$j]}++;
        }#foreach

     $G = $base{G};
     $C = $base{C};
     $A = $base{A};
     $T = $base{T};
  }#if m

}#while IN
close(IN);

$gsize=$A + $T + $C + $G;

$GC = ($G + $C )*100/$gsize;
@p=split(/[\.]/, $GC);
$d=substr($p[1],0,2);

$GCp="$p[0]".".$d";

print "$IN\tA\tC\tT\tG\tGC%\tsize\n";
print "Count\t$A\t$C\t$T\t$G\t$GCp\t$gsize\n";
