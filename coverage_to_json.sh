#!/bin/bash
#
# Parses the LLVCM code coverage report and outputs a JSON string with the percentage
# Author: Paulo Fierro <paulo@paulofierro.com>
# Date: July 19, 2022
#
./coverage.sh export | \
  jq '.data[0].totals.functions.percent' | \
  awk '{printf("%.2f%%",$1)}' | \
  ( percentage=($(< /dev/stdin)); echo "{\"schemaVersion\": 1, \"label\": \"Coverage\", \"message\": \"${percentage}\", \"color\": \"green\"}" )