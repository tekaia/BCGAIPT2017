#!/bin/perl

#translate lower case characters into upper case characters

#use: more inputfile | tr.pl > outputfile

while(<>)
  {

$_ =~ tr/a-z/A-Z/;
print $_;

  }
