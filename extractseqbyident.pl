#!/usr/bin/perl

# extract one sequence corresponding to the identifier $IN from a file of sequences
#dbfile is assumed with extension ".seq", ".pep" or ".dna"
#outputfile has extension ".dna" dna or ".prt" for protein sequences.
#Use: extractseqbyident.pl sequence_ident dbfile &

#exp. extractseqbyident.pl YAL064wb GSACE.pep &

$IN=@ARGV[0];  # sequence name to look for in the db
$DB=@ARGV[1];  # db name

$SEQ=">"."$IN";
$db=$DB;

$db =~ s/.*\.p/p/g;
$db =~ s/.*\.d/d/g;
$db =~ s/.*\.s/s/g;

$ext=$db;
if ($ext eq "pep" ) { $ext = "prt"; }

$OUT=" $SEQ".".$ext";
open (OUT,"$OUT");

$found=0;
open(DB,"$DB") || die "can't open $DB";
while(<DB> )
{
    @tab=split(/\s+/,$_);

    if ( m />/ && $found == 1 ) { exit; }

    if ( $tab[0] eq $SEQ )  { $found=1;  }
    if ( $found == 1     )  { print OUT $_; }

} #while DB

if ($found == 0 ) { print "$IN not found in $DB\n"; }
