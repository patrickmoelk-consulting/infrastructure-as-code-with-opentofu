#!/usr/bin/env bash

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

source ${parent_path}/sh-lib/colors.sh
source ${parent_path}/sh-lib/s3.sh
source ${parent_path}/sh-lib/requirements.sh


function main() {
	bucket_name="$1"
	file_path="$2"
	key="$3"

	echo "uploading file \"${file_path}\" to bucket \"${bucket_name}\" as key \"${key}\"";
	upload_file "${bucket_name}" "${file_path}" "${key}"
}


if [[ $# -ne 3 ]]; then
	echo -e "${RED_COLOR}ERROR: Expect exactly three arguments: <bucket-name> <local-file-path> <s3-key>. Provided $# arguments.${CLEAR_COLOR}";
	exit -1;
fi

check_requirements
main "$1" "$2" "$3";