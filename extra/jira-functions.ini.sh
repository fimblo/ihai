# This bash code is intended to be sourced, not run.

GOJIRA_BASE=$HOME/.jira.d
GOJIRA_CONFIG=$GOJIRA_BASE/config.yml
GOJIRA_PROJECT_FILE=$GOJIRA_BASE/project


_gojira_is_set_up () {

  if ! which jira > /dev/null 2>&1 ; then
    echo "Can't find jira in PATH."
    return 1
  fi
  if ! [[ -e $GOJIRA_CONFIG ]] ; then
    echo "go-jira configuration not found."
    return 1
  fi
  if ! [[ -e $GOJIRA_PROJECT_FILE ]] ; then
    echo "Create $GOJIRA_PROJECT_FILE and add your jira projectname on its own line."
    return 1
  fi
  
  PROJECT=$(cat $GOJIRA_PROJECT_FILE)
  GOJIRA_RUN_PREFIX="project=$PROJECT and issuetype in (Task, Bug, Story)"
  return 0
}



# GO-JIRA
jtodo () {
  _gojira_is_set_up && \
    jira list -q "$GOJIRA_RUN_PREFIX and status = 'To do'"
}
jdoing () {
  _gojira_is_set_up && \
    jira list -q "$GOJIRA_RUN_PREFIX and status = 'In Progress'"
}
jreview () {
  _gojira_is_set_up && \
    jira list -q "$GOJIRA_RUN_PREFIX and status = 'Review & QA'"
}
jtable () {
  _gojira_is_set_up && \
    jira list -q "$GOJIRA_RUN_PREFIX and status in ('To do', 'In Progress', 'Review & QA')" -t table
}
