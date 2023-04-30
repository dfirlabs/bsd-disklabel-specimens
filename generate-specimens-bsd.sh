#!/usr/bin/env bash
#
# Script to generate BSD disklabel test files
# Requires BSD with dd and bsdlabel

EXIT_SUCCESS=0;
EXIT_FAILURE=1;

# Checks the availability of a binary and exits if not available.
#
# Arguments:
#   a string containing the name of the binary
#
assert_availability_binary()
{
	local BINARY=$1;

	which ${BINARY} > /dev/null 2>&1;
	if test $? -ne ${EXIT_SUCCESS};
	then
		echo "Missing binary: ${BINARY}";
		echo "";

		exit ${EXIT_FAILURE};
	fi
}

assert_availability_binary bsdlabel;
assert_availability_binary dd;

SPECIMENS_PATH="specimens/bsdlabel";

if test -d ${SPECIMENS_PATH};
then
	echo "Specimens directory: ${SPECIMENS_PATH} already exists.";

	exit ${EXIT_FAILURE};
fi

mkdir -p ${SPECIMENS_PATH};

set -e;

IMAGE_SIZE=$(( 4 * 1024 * 1024 ));
SECTOR_SIZE=512;

IMAGE_FILE="${SPECIMENS_PATH}/disklabel.raw";

dd if=/dev/zero of=${IMAGE_FILE} bs=${SECTOR_SIZE} count=${IMAGE_SIZE} 2> /dev/null;

bsdlabel -w -f ${IMAGE_FILE};

exit ${EXIT_SUCCESS};

