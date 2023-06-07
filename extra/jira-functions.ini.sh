# This bash code is intended to be sourced, not run.
#
# You might need to change some things for it to work for you. Places
# to check:
#
# - The board I work in follows the Kanban flow. This _should_ work
#   even if yours is a scrum board, but I haven't tested it.
#
# - The default ticket types. The ones I'm interested in are Task,
#   Bug, and Story, and they are set in the variable
#   GOJIRA_RUN_PREFIX. Change to fit your tickets of choice.
#
# - The default statuses. The ones I have in my Jira workflow are:
#   'Backlog', 'To do', 'In Progress', 'Review & QA', 'Done'. You can
#   see them in the shell functions prefixed with 'j' below. Change as
#   you see fit.

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
jbacklog () {
  _gojira_is_set_up && \
    jira list -q "$GOJIRA_RUN_PREFIX and status = 'Backlog'"
}
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
