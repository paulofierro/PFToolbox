#!/bin/bash
#
# Outputs the code coverage report as a summary ("report") or JSON ("export")
# Author: Paulo Fierro <paulo@paulofierro.com>
# Date: July 19, 2022
#
TYPE=$1
if [ -z "$TYPE" ]
then
    echo "Please supply an output type, e.g. report or export"
    exit 1
fi
xcrun llvm-cov "${TYPE}" .build/x86_64-apple-macosx/debug/PFToolboxPackageTests.xctest/Contents/MacOS/PFToolboxPackageTests \
              -instr-profile=.build/x86_64-apple-macosx/debug/codecov/default.profdata \
              -ignore-filename-regex=".build|Tests"