#!/usr/local/bin/perl
eval "exec /usr/local/bin/perl -S $0 $*"
      if $running_under_some_shell;

#
# split a fasta file (dbfile) into separate sequence files
#
$IN=@ARGV[0];
# use splitfasta.pl dbfile

if ($IN eq "") { print "\n\nUse: splitdnafatsa.pl nuc_sequence_dbfile\n\n";exit;}

$/ = '\777'; # entire input to be read in one slurp

$seqs = <>;  # read input, assigning to single string

while ($seqs =~ m/^(>[^>]+)/mg) { # match indiv. sequences by '>'s
	push(@seqs,$1);           # and store in array
}

for (@seqs) {
	# only allow characters A-Z,a-z,0-9,'_','-', and '.' in names;
	# change if you're more liberal
	/^> *([\w\-\.]+)/ && ($seq_name = $1);
	if ($seq_name) {
		open(OUTFILE,">$seq_name.dna");
		print OUTFILE "$_";
	}
	else {
		warn "couldn't recognise the sequence name in \n$_";
	}
}
	
__END__;
