#!/bin/bash
#
# Outputs the code coverage report as a printed summary and JSON
# Author: Paulo Fierro <paulo@paulofierro.com>
# Date: Jan 20, 2023
#

BUILD_PATH="./.build/"
PACKAGE_NAME="PFToolbox"
OUTPUT_FILE="lcov.info"
COVERAGE_PATH="${BUILD_PATH}/x86_64-apple-macosx/debug/${PACKAGE_NAME}PackageTests.xctest/Contents/MacOS/${PACKAGE_NAME}PackageTests"
PROFILE="${BUILD_PATH}/x86_64-apple-macosx/debug/codecov/default.profdata"
IGNORE="${BUILD_PATH}|Tests"

# Print out the tabular report
xcrun llvm-cov report ${COVERAGE_PATH} \
    -instr-profile=${PROFILE} \
    -ignore-filename-regex=${IGNORE} \
    -use-color

# Convert the report as LCOV which Codecov.io can upload
xcrun llvm-cov export ${COVERAGE_PATH} \
    -instr-profile=${PROFILE} \
    -ignore-filename-regex=${IGNORE} \
    -format=lcov \
    > ${OUTPUT_FILE}

echo "Code coverage exported to ${OUTPUT_FILE}"
