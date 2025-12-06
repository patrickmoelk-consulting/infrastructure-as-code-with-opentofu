#!/usr/bin/env bash

profile=opentofu-workshop

function check_aws_cli() {
	if [[ ! $(which aws) ]]; then
		echo -e "${RED_COLOR}ERROR: aws CLI is required. Please install it, see here: https://aws.amazon.com/cli/ ${CLEAR_COLOR}";
		exit 1;
	fi

	if [[ ! $(aws --endpoint-url "http://localhost:4566" --region eu-central-1 --profile ${profile} sts get-caller-identity) ]]; then
		echo -e "${RED_COLOR}ERROR: you must have an AWS CLI profile named ${profile} in you ~/.aws/config file.${CLEAR_COLOR}";
		exit 1;
	fi
}

function check_requirements() {
	check_aws_cli
}
