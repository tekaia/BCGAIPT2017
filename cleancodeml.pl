#!/bin/perl

#clean codeml output files keeping NG and codeml estimations.
#results are presented in a table form

$IN=@ARGV[0]; # input codeml file results
$iflag=$iflage=$iflagseq=0;

$in=substr($IN,0,length($IN) -6);
$inNG="$in"."NG";
$inYN="$in"."CML";
open (OUTNG,">$inNG");
open (OUTYN,">$inYN");
open(IN,"$IN") || die "cant open $IN";
while(<IN>)
{

    if ( m/^CODONML/ ) 
    { print OUTNG $_; 

    s# \(.*\) # #go;
      @tab=split(/\s+/, $_);
      $FAM=substr($tab[1], 0, length($tab[1])-8);
 print OUTYN"$tab[0]\tModel: One dN/dS ratio,\tPairwise comparison, Codon frequencies: F3x4\n";
##    print OUTYN $_; 

    }#if m


    if ( m/^Codon frequencies/ ) { print OUTNG $_;}
    if ( m/^ns/   ) 
    { print OUTNG $_; 

    s#^ns =##go;
    s#ls =##go;
      @tab=split(/\s+/, $_);
      $ns=$tab[1];
      $ls=$tab[2];
##print "ns line:";      print $_;
##    print OUTYN "ns= $ns\tls= $ls\n";; 


    }## ns

    if ( m/^Nei & Gojobori 1986/ ) { $iflag = 1; print OUTNG "\n"; $i=0; }
    if ( $iflag == 1 ) 
    { 

      if ( m/^pairwise comparison, codon frequencies: F3x4/ ) { $iflage = 1; }
      print OUTNG $_ if ( $iflage == 0 );

      if ( $i >= 1 && $iflage == 0 && length($_) > 1 ) 
                    { @tab=split(/\s+/, $_ );
		      $NOMSEQ{$i} = $tab[0];
		    }#if $i
    $i++;
    }#if iflag

#pairwise comparison,...

if ( $iflage == 1 )
{

    if ( m/^pairwise/ && $iflagseq == 0 )
{
##print OUTYN $_; 
print OUTYN "Fam\tseq\tseq\tns\tls\tt\tS\tN\tdN/dS\tdN\tdS\n";
}#if m /
   $iflagseq = 1 if ( m/^pairwise/);

if ( $iflagseq == 1 )
{

    if ( m/ \.\.\. / ) 
    { 
s#\(##go;
s#\)##go;

### print $_;

	@tab=split(/\s+/, $_ );
print OUTYN "$FAM\t$tab[1]\t$tab[4]\t$ns\t$ls\t";
    }#if m

    if ( m/^t=/ )
    {

    s#dN\/dS=# #go;
    s#dN=# #go;
    s#dS=# #go;
    s#t=# #go;
    s#S=# #go;
    s#N=# #go;

## print $_;
	@tab=split(/\s+/, $_ );
print OUTYN "$tab[1]\t$tab[2]\t$tab[3]\t$tab[4]\t$tab[5]\t$tab[6]\n";

    }

}$iflagseq;

}#iflage

    
} #while
print OUTYN "\n";



