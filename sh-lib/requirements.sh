#!/usr/bin/env bash

function check_aws_cli() {
	if [[ ! $(which aws) ]]; then
		echo -e "${RED_COLOR}ERROR: aws CLI is required. Please install it, see here: https://aws.amazon.com/cli/ ${CLEAR_COLOR}" >&2;
		exit 1;
	fi

	if [[ -z "$AWS_PROFILE" ]]; then
		echo -e "${YELLOW_COLOR}WARNING: environment variable AWS_PROFILE is NOT set, falling back to the \"default\" profile.${CLEAR_COLOR}";
	fi
	
	aws sts get-caller-identity > /dev/null
	if [[ $? -ne 0 ]]; then
		echo -e "${RED_COLOR}ERROR: you must have an AWS CLI profile named \"${AWS_PROFILE-default}\" in your ~/.aws/config file. In case you're using SSO, you also need to be signed in, e.g. using aws-sso-util login --profile ${AWS_PROFILE-default}.${CLEAR_COLOR}" >&2;
		exit 1;
	fi
}

function check_requirements() {
	check_aws_cli
}
