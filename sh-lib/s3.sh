#!/usr/bin/env bash

profile=opentofu-workshop

function upload_file() {
	bucket="$1"
	filepath="$2"

	aws --endpoint-url http://localhost:4566 --profile ${profile} s3api put-object --bucket="${bucket}" --key="${filepath}" --body="${filepath}" > /dev/null
}

function delete_file() {
	bucket="$1"
	filepath="$2"

	aws --endpoint-url http://localhost:4566 --profile ${profile} s3api delete-object --bucket="${bucket}" --key="${filepath}" > /dev/null
}
