#!/usr/bin/perl
#usage: seqsize.pl sequence(fasta format)

$IN=@ARGV[0];
$size=0;

open(IN, "$IN");

while (<IN>)
{
    if (m/^>/) 
          {
	  @tab=split(/\s+/, $_);
	   $ID=$tab[0];
	   $ID =~ s/>//g;
	   print $ID;
	  }#if m
   
     if (!m/>/)
        {
	chomp ($_);
        $L=length($_); 
	$size=$size + $L;
	}#if non m

}#while
print "\t$size\n";
