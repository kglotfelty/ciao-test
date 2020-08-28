###############################################################
#
# Configure environment for running CIAOTEST
# regression-testing tools
#
###############################################################


#
# The following declarations will differ for each
# local installation
#
ROOT=/proj/sds/Regression

# Installation directory for CIAOTEST software
export CIAOTEST_INSTALL=${ROOT}/ciaotest

# Directory containing test files
export CIAOTEST_TESTS=${ROOT}/current_regtest/tests

# Directory containing input files for tests
export CIAOTEST_INPUT=${ROOT}/current_regtest/input

# Directory to which test results are written
export CIAOTEST_RESULTS=${ROOT}/results

# Directory containing dmdiff tolerance files (optional)
export CIAOTEST_TOLFILES=${ROOT}/current_regtest/tolfiles


#
# The following declarations are the same for all
# installations
#

# Directory containing executable CIAOTEST scripts
export CIAOTEST_BIN=$CIAOTEST_INSTALL/bin

# Directory containing definitions of internal CIAOTEST functions
export CIAOTEST_FUNCTIONS=$CIAOTEST_INSTALL/lib

# Set PATH appropriately
PATH="${CIAOTEST_BIN}:${CIAOTEST_FUNCTIONS}:${PATH}"

# Set FPATH so that ksh finds the functions defined in
# $CIAOTEST_FUNCTIONS

if test x$FPATH = x
then
  export FPATH="$CIAOTEST_FUNCTIONS"
else
  export FPATH="${CIAOTEST_FUNCTIONS}:${FPATH}"
fi

unset ROOT

