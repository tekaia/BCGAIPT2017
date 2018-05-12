#!/usr/bin/perl

#extract from allxxxx files highly significant hits (eliminate self-hits)
#Use printallhits.pl allxxxx & 
#output is allxxxx.HS

$IN=@ARGV[0]; #allsacesace   (with -outfmt 6 option)
open(OUT,">$IN.HS");  # all HS hits
open(IN,"$IN");
while(<>)
  {
@tab=split(/\s+/, $_);

print OUT $_ if ( $tab[0] ne $tab[1]);

  }
close(IN);
close(OUT);
