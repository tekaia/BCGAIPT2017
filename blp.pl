#!/bin/perl

#run blastp to compare all individual sequences in allsaceprt.fasta to the GSACE.pep database
#blastp with -evalue 1.e-9 -outfmt 6 options
#tabular forms results will be directed to allsacesace file and whole blast results to the SACEresblp directory.
#Use nohup blp.pl &

@SEQ=`ls $BLASTDB/allsaceprt.fasta`;
while( $S = shift @SEQ)
  {
chomp($S);

system("cp $BLASTDB/allsaceprt.fasta/$S .");
system("blastp -query $S -db GSACE.pep -use_sw_tback –evalue 1.e-9 –seg yes –outfmt 6  -out $S.blp6");
system("blastp -query $S -db GSACE.pep -use_sw_tback -evalue 1.e-9 -seq yes -num_descriptions 300 –num_alignments 300 -outfmt $S.blp");
system("mv $S.blp SACEresblp/");
system("cat $S.blp6 >> SACEseqnew/allsacesace");
system("rm $S.blp6 $S");

  }
