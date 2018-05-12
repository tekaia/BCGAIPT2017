#!/usr/bin/perl

#compute base content, GC% and size of fasta formatted sequences dbfile
#Use freqnt1linebyseq.pl dbfile.dna or dbfile.seq > dbfilednabasecompbyseq.tab

$IN=@ARGV[0];

print "$IN\tA\tC\tT\tG\tGC%\tsize\n";
$i=0;
open(IN, $IN);
while(<IN>)
{
    if ($i == 0 && m/^>/ ) {@tab=split(/\s+/, $_); $seqid = substr($tab[0], 1, length($tab[0])); }

 if ( m/^>/ && $i > 0 )
 {

     $seqidP=$seqid;

     $gsize=$A + $T + $C + $G;

     $GC = ($G + $C )*100/$gsize;
     @p=split(/[\.]/, $GC);
     $d=substr($p[1],0,2);

     $GCp="$p[0]".".$d";

     print "$seqidP\t$A\t$C\t$T\t$G\t$GCp\t$gsize\n";

     @tab=split(/\s+/, $_);
     $seqid = substr($tab[0], 1, length($tab[0]));
     $G = $C = $A = $T = $GC = $GCp = 0;

 }# if m/>

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
     $i++;
}#while IN
close(IN);

$gsize=$A + $T + $C + $G;

$GC = ($G + $C )*100/$gsize;
@p=split(/[\.]/, $GC);
$d=substr($p[1],0,2);

$GCp="$p[0]".".$d";

#print "$IN\tA\tC\tT\tG\tGC%\tsize\n";
print "$seqid\t$A\t$C\t$T\t$G\t$GCp\t$gsize\n";
