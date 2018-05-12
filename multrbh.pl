#!/usr/bin/perl

#multiple rbh computing: pair-wise rbh computation between a set of species
#use multrbh.pl genomelist &
#outputs xxyy.rbh that should be directed to the directory RBH

$IN=@ARGV[0];

open(IN,"$IN");
$i=0;
while(<IN>)
{
    $i++;
    @tab=split(/\s+/,$_);
    $SPEC{$i} = $tab[0];
}
close(IN);

foreach $j ( 1 .. $i )
{
      foreach $k ( $j+1 .. $i )
      {

      if ( $k != $j )
      {
	  $SPEC1 = $SPEC{$j};
          $SPEC2 = $SPEC{$k};

          $spec1 = $SPEC1;
          $spec1 =~ tr/A-Z/a-z/;
          $specé = $SPEC2;
          $spec2 =~ tr/A-Z/a-z/;

#paths to bestxxyy.HS file (to be adapted)
	  $PD1 = "~/home0/genanal/genomes/$SPEC1/$SPEC2seqnew";
          $PD2 = "/home0/genanal/genomes/$SPEC2/$SPEC1seqnew";

          cp $PD1/best$spec1$spec2.HS .
          cp $PD2/best$spec2$spec1.HS .

          system("rbh.pl best$spec1$sepc2.HS best$spec2$spec1.HS"); 
#output file is $spec1$spec2.rbh
	  system("mv $spec1$spec2.rbh $path/RBH");
      }#if

      }#foreach $k

}# foreach $j
