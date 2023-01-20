#!/bin/bash
#
# Outputs the code coverage report as a printed summary and JSON
# Author: Paulo Fierro <paulo@paulofierro.com>
# Date: Jan 20, 2023
#

BUILD_PATH="./.build/"
PACKAGE_NAME="PFToolbox"

#
# Extracts the LLVM code coverage as either a tabular report or export (JSON)
#
extractCoverage() {
  xcrun llvm-cov $1 ${BUILD_PATH}/x86_64-apple-macosx/debug/${PACKAGE_NAME}PackageTests.xctest/Contents/MacOS/${PACKAGE_NAME}PackageTests \
    -instr-profile=${BUILD_PATH}/x86_64-apple-macosx/debug/codecov/default.profdata \
    -ignore-filename-regex="${BUILD_PATH}|Tests"
}

# Print out the tabular report
extractCoverage report

# Convert the exported JSON into our own format and save it as coverage.json
extractCoverage export | \
  jq '.data[0].totals.functions.percent' | \
  awk '{printf("%.2f%%",$1)}' | \
  ( percentage=($(< /dev/stdin)); echo "{\"schemaVersion\": 1, \"label\": \"Coverage\", \"message\": \"${percentage}\", \"color\": \"orange\"}" ) \
  > coverage.json
