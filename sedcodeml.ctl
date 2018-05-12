#!/bin/sh

cp  /home0/gensoft/PAML/paml/codeml.ctl X.ctl

sed -e "s/seqfile.*/   seqfile = $1/g" -e "s/outfile.*/outfile = $1.codeml/g" X.ctl > $1.ctl

rm X.ctl
