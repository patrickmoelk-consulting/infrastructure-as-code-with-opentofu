#!/usr/bin/env bash

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

source ${parent_path}/sh-lib/colors.sh
source ${parent_path}/sh-lib/s3.sh
source ${parent_path}/sh-lib/requirements.sh


function main() {
	bucket_name="$1"

	echo "emptying and then deleting bucket \"${bucket_name}\"...";

	if ! aws s3api head-bucket --bucket "${bucket_name}" > /dev/null; then
		echo -e "${YELLOW_COLOR}The specified bucket does not seem to exist!${CLEAR_COLOR}";
		exit -1;
	fi

	empty_bucket ${bucket_name}
	if aws s3api delete-bucket --bucket "${bucket_name}"; then
		echo -e "${GREEN_COLOR}successfully deleted bucket \"${bucket_name}\"!";
	fi
}

function empty_bucket() {
	bucket_name="$1"
	echo "Emptying bucket \"${bucket_name}\"...";

	delete_object_versions "${bucket_name}";
	delete_delete_markers "${bucket_name}";
}

function delete_object_versions() {
	bucket_name="$1"

	echo "Deleting object versions...";
	object_versions=$(get_object_versions "${bucket_name}")
	# echo "OBJECT VERSIONS: ${object_versions}"
	if [[ $object_versions == *"\"Objects\": null"* ]]; then
		echo "Object versions already deleted...";
	else
		echo $(aws s3api delete-objects --bucket "${bucket_name}" --delete "${object_versions}")
	fi
}

function get_object_versions() {
	bucket_name="$1"

	aws s3api list-object-versions --bucket "${bucket_name}" --output json --query '{Objects: Versions[].{Key:Key,VersionId:VersionId}}'
}

function delete_delete_markers() {
	bucket_name="$1"

	echo "Deleting delete markers...";
	delete_markers=$(get_delete_markers "${bucket_name}")
	# echo "DELETE MARKERS: ${delete_markers}"
	if [[ $delete_markers == *"\"Objects\": null"* ]]; then
		echo "Delete markers already deleted...";
	else
		echo $(aws s3api delete-objects --bucket ${bucket_name} --delete "${delete_markers}")
	fi
}

function get_delete_markers() {
	bucket_name="$1"

	aws s3api list-object-versions --bucket "${bucket_name}" --output json --query '{Objects: DeleteMarkers[].{Key:Key,VersionId:VersionId}}'
}



if [[ $# -ne 1 ]]; then
	echo -e "${RED_COLOR}ERROR: Expect exactly one argument: <bucket-name>. Provided $# arguments.${CLEAR_COLOR}";
	exit -1;
fi


check_requirements
main "$1";