#!/usr/bin/env bash

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

source ${parent_path}/sh-lib/colors.sh
source ${parent_path}/sh-lib/s3.sh
source ${parent_path}/sh-lib/requirements.sh


function main() {
	bucket_name="$1"
	file_path="$2"

	echo "deleting file \"$2\" from bucket \"$1\"";
	delete_file "${bucket_name}" "${file_path}"
}


if [[ $# -ne 2 ]]; then
	echo -e "${RED_COLOR}ERROR: Expect exactly two arguments: <bucket-name> <s3-key>. Provided $# arguments.${CLEAR_COLOR}";
	exit -1;
fi

check_requirements
main "$1" "$2";