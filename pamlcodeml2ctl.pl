#!/bin/perl

#constructs ctl files coresponding to paml file
#used with paml program


@PAML=`ls *.paml`;

while( $P = shift @PAML)
{

    system("sedcodeml.ctl $P");

}
