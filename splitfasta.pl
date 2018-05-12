#!/usr/bin/perl

#split a fasta database into individual fasta sequences
#use splitfasta.pl dbfile &

$IN=@ARGV[0];
open(IN,"$IN");

#guess from the 100 first lines if dbfile includes aa or dna sequences
system (`head -100 $IN | sed -e "/>/d"  > temp`);
open(T,"temp");

$ext="dna";
while(<T>)
{
if (m/R/ || m/r/ || m/P/ || m/p/ || m/L/ || m/l/ || m/V/ || m/v/ || m/K/ || m/k/ ) { $ext="prt"; } 
}
close(T);
system("rm temp");

while(<IN>)
{

if (m/^>/ )
   {
       close(S);
       @tab=split(/\s+/,$_);
       $seq=substr($tab[0],1,length($tab[0]));
       $seq=$seq.".$ext";
       open (S,">$seq");
   }# if m/>/
print S $_;

}#while IN
