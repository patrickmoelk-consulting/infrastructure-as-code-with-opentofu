#!/usr/bin/env bash

function upload_file() {
	bucket="$1"
	filepath="$2"
	key="$3"

	aws s3api put-object --bucket="${bucket}" --key="${key}" --body="${filepath}" > /dev/null
}

function delete_file() {
	bucket="$1"
	key="$2"

	aws s3api delete-object --bucket="${bucket}" --key="${key}" > /dev/null
}
