#!/usr/bin/perl
#usage: allORTHPAR.pl SACE.mclpar CAGL.mclpar ZYRO.mclpar ORTH.mclclusters >  sfamORTH-MCL
#output file: ORF_ident Cn.m Cp.q Cn.m-Cp.q  (Cn.m: orthologs cluster; Cp.q: paralogs cluster or single).

$X=@ARGV[0];
$Y=@ARGV[1];
$Z=@ARGV[2];
$ID=@ARGV[3];

#X.mclpar structure: Cn.m Size ORF_ident
open (X,"$X");
while (<X>)
{
    @tab=split(/\s+/, $_);
    $SACEPAR{$tab[0]}=$tab[1];
}#while1

open (Y,"$Y");
while (<Y>)
{
    @tab=split(/\s+/, $_);
    $CAGLPAR{$tab[0]}=$tab[1];
}#while2

open (Z,"$Z");
while (<Z>)
{
    @tab=split(/\s+/, $_);
    $ZYROPAR{$tab[0]}=$tab[1];
}#while3

#$ID structue: Cn.m size ORF_ident
open (ID, "$ID");
while (<ID>)
{
    chomp $_;
    @tab=split(/\s+/, $_);
    print "$tab[2]\t";
    print "$tab[0]";
    if ($SACEPAR{$tab[2]}) {print "$SACEPAR{$tab[2]}\t"; $cpar = $SACEPAR{$tab[2]}; }
    if ($CAGLPAR{$tab[2]}) {print "$CAGLPAR{$tab[2]}\t"; $cpar = $CAGLPAR{$tab[2]}; }
    if ($ZYROPAR{$tab[2]}) {print "$ZYROPAR{$tab[2]}\t"; $cpar = $ZYROPAR{$tab[2]}; }
    $COP = "$tab[0]"."-"."$cpar";
    print "$COP\n";
}#while4

close (X);
close (Y);
close (Z);
close (ID);
