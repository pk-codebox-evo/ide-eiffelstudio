#!/bin/bash
cd $1
echo -e "y\nI\nL\nW\nM\nQ\nQ\n" | ec -loop -config config.ecf -target sut
echo -e "I\nD\nL\nK\nQ\nQ\nM\nT\nR\nQ\nQ\n" | ec -loop -config config.ecf -target sut 3>&1 1>&2 2>&3 | sed -r 's/(^  - directory =.*)//g' | sed -r 's/(^  - arguments =.*)//g' | sed -r 's/(^Application.*)//g' | sed -r 's/(^Launching.*)//g' | tee zzz.outcome
