#!/bin/sh
#
# Script to generate BSD disklabel test files
# Requires BSD with dd and disklabel

EXIT_SUCCESS=0;
EXIT_FAILURE=1;

SPECIMENS_PATH="specimens/bsd-disklabel";

if test -d ${SPECIMENS_PATH};
then
	echo "Specimens directory: ${SPECIMENS_PATH} already exists.";

	exit ${EXIT_FAILURE};
fi

mkdir -p ${SPECIMENS_PATH};

set -e;

SECTOR_SIZE=512;

IMAGE_FILE="${SPECIMENS_PATH}/bsd-disklabel.raw";
IMAGE_SIZE=8192;

dd if=/dev/zero of=${IMAGE_FILE} bs=${SECTOR_SIZE} count=${IMAGE_SIZE} 2> /dev/null;

exit ${EXIT_SUCCESS};

