#!/usr/bin/env bash
# Install prerequisites to ihai

ME=$(basename $0)
JIRA_CONFIG=$HOME/.jira.d/config.yml

echo "Setting up go-jira. Press enter to continue, ctrl-c to abort."
read
if ! which jira > /dev/null 2>&1 ; then
  cat<<-EOF
	Install go-jira first before running this script.
	https://github.com/go-jira/jira
	EOF
  exit 0
fi

read -p 'Jira endpoint: '
JIRA_ENDPOINT="$REPLY"
read -p 'Jira username: '
JIRA_USER="$REPLY"
read -p 'Default Jira project (press enter to skip): '
[[ "$REPLY" ]] && JIRA_PROJECT="project: $REPLY"

mkdir -p $(dirname $JIRA_CONFIG)
[[ -e $JIRA_CONFIG ]] && mv $JIRA_CONFIG ${JIRA_CONFIG}.bk

cat <<-EOF > $JIRA_CONFIG
	# Config created by $ME
	# $(date)
	endpoint: $JIRA_ENDPOINT
	user: $JIRA_USER
	password-source: keyring
	$JIRA_PROJECT
	EOF

cat<<-EOF
	
	Config file created at ${JIRA_CONFIG}.
	---
	
	
	You now have two remaining things to do:
	
	1. Get your API TOKEN
	   Now head to the url below and obtain your API TOKEN.
	   https://id.atlassian.com/manage-profile/security/api-tokens
	   
	   When you have it, run the command 'jira session' and paste the token
	   when prompted.
	
	2. (Optional) Add ihai to your PATH
	   This if you want to be able to run it from anywhere in the filesystem.
	
	All done!
	EOF
exit 0
