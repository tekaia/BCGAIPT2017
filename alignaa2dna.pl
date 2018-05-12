#!/bin/perl

#align dna sequences according to their corresponding aa sequences for PAML use.
#input alignment is assumed a one line sequence ( see multalign2oneline.pl script).
# corresponding dna sequences are assumed to be in the same directory
# and in a one line form (see multalign2oneline.pl script).
#USE: alignaa2dna.pl aa_alignment &
#output file is the dna alignment in paml format: dna_alignment.paml

$INA=@ARGV[0];
open (OUT,">>$INA.paml");
open(INA,"$INA") || die "can't open $INA";
$i=0;
while(<INA>)
{

    @tab=split(/\s+/, $_ );

##################### remove ">" for paml use  ######
    if ( m/>/ ) { $seq=substr($tab[0], 1, length($tab[0]) ); $i++; print OUT "\n$tab[0]   ";}

    if ( !m/>/ )  {
	$Laa=length($tab[0]);
    open (DNA,"$seq.dna") || die "can't find $seq.dna";
    while(<DNA>)
    {
	@SEQ=split(/\s+/, $_ );

    if ( !m/>/)
    { 
    $LSEQ=length($SEQ[0]);
    $k=0;
    foreach $j ( 0 .. $Laa -1 )
     { 
	$aa = substr($tab[0], $j, 1 );
	if ( $aa eq "-" ) { print OUT "---"; }
        if ( $aa ne "-" ) { $k++; $k1=$k*3-3; $k2=$k*3 -1; 
                            $codon=substr($SEQ[0], $k1, 3 );
                            print OUT $codon;
			  }
     }
    } # !m/>/ DNA
    }#while DNA
	close(DNA);

        $DIFFB = $LSEQ - 3*$k;
	if ( $LSEQ != 3*$k ) { print "\nSequence size problem: $seq.dna ($LSEQ) and $seq.prt ($k)\tDiff.bases=$DIFFB\n"};

                   } # if (!m/>/ )
} # while INA

close(OUT);
##print "\nInclude in the first line of the obtained paml file:\n";

$LC=$Laa*3;

open(T,">temp");
print T "$i\t$LC";
close(T);

$PAML="$INA".".paml";

system("cat $INA.paml >> temp");

system("mv temp $PAML");

