###############################################################
#
# Configure environment for running CIAOTEST
# regression-testing tools
#
###############################################################


#
#
#
set ROOT=/proj/sds/Regression

# Test inputs:
#
#  ${CIAOTEST_REPOSITORY}/${tool}/tests
#  ${CIAOTEST_REPOSITORY}/${tool}/input
#  ${CIAOTEST_REPOSITORY}/${tool}/baseline
#  ${CIAOTEST_REPOSITORY}/${tool}/${tool}.tol
#

export CIAOTEST_REPOSITORY=${ROOT}/goober

#
# Output Directory to which test results are written
#
export CIAOTEST_RESULTS=${ROOT}/results



#
# Installation directory for CIAOTEST software
#
export CIAOTEST_INSTALL=${ROOT}/ciao-test

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

