#!/bin/perl

#use codeml.pl

@PAML=`ls *.paml.ctl`;

while( $P = shift @PAML)
{

    system ("codeml $P ");

$ML=substr($P,0,length($P)-13);
    system ("mv 2ML.t $ML.2ML.t");
    system ("mv 2ML.dN $ML.2ML.dN");
    system ("mv 2ML.dS $ML.2ML.dS");

}
