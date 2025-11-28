#!/usr/bin/env bash

source ../../sh-lib/colors.sh
source ../../sh-lib/s3.sh
source ../../sh-lib/requirements.sh


function main() {
	bucket_name="$1"
	file_path="$2"

	echo "uploading file \"$2\" to bucket \"$1\"";
	upload_file "${bucket_name}" "${file_path}"
}


if [[ $# -ne 2 ]]; then
	echo -e "${RED_COLOR}ERROR: Expect exactly two arguments: <bucket-name> <local-file-path>. Provided $# arguments.${CLEAR_COLOR}";
	exit -1;
fi

check_requirements
main "$1" "$2";