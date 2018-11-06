#!/bin/bash
# Display Pull Requests
# created by Demian Ginther
# st.diluted@gmail.com

[[ -z "${GITHUB_API_TOKEN}" ]] && github_api_token='' || github_api_token="${GITHUB_API_TOKEN}"
github_username=""
github_org=""
github_repo=""

jq_exe="/usr/local/bin/jq"
curl_exe="/usr/bin/curl"

command -v $jq_exe >/dev/null 2>&1  || { echo >&2 "I require jq but it's not installed.  Aborting."; exit 1; }
command -v $curl_exe >/dev/null 2>&1  || { echo >&2 "I require curl but it's not installed.  Aborting."; exit 1; }

# Get a list of open PRs for the specified user
pr_list=`$curl_exe -ks -H "Authorization: token $github_api_token" https://api.github.com/repos/$github_org/$github_repo/pulls|/usr/local/bin/jq -r '.[] | select(.requested_reviewers[].login == "'$github_username'")| { title: .title, URL: .html_url }'`

# code into Base64 and decide to properly split lines.
for row in $(echo "${pr_list}"| $jq_exe -r '.[] | @base64'); do
  line=`echo ${row} | base64 --decode`
  echo -e "$line"
done
