#!/bin/bash

# This script downloads all repositories from a Bitbucket Server instance.
# It uses the BITBUCKET_APIKEY environment variable for authentication.
# Repositories are cloned into directories named after their project keys.
# Requirements: curl, jq

# Configuration
BITBUCKET_URL="https://git.maxpool.ir"
BITBUCKET_APIKEY="BBDC-Nzk4NTk3NDYyODg4OhoPYTlbPiAcgH6hfHIYiF7EEQVD"
AUTH_HEADER="Authorization: Bearer $BITBUCKET_APIKEY"

# Check if BITBUCKET_APIKEY is set
if [ -z "$BITBUCKET_APIKEY" ]; then
  echo "Error: BITBUCKET_APIKEY environment variable is not set."
  exit 1
fi

# Function to fetch all items with pagination
fetch_all_items() {
  local url="$1"
  local items_json=""
  local is_last_page="false"
  local start=0

  while [ "$is_last_page" != "true" ]; do
    response=$(curl -s -H "$AUTH_HEADER" "$url&start=$start")
    if [ $? -ne 0 ]; then
      echo "Error: Failed to fetch data from $url"
      exit 1
    fi
    items_json+=$(echo "$response" | jq -c '.values[]')
    items_json+=$'\n'
    is_last_page=$(echo "$response" | jq -r '.isLastPage')
    if [ "$is_last_page" != "true" ]; then
      start=$(echo "$response" | jq -r '.nextPageStart')
    fi
  done

  echo "$items_json"
}

# Fetch all projects
echo "Fetching projects..."
projects_url="$BITBUCKET_URL/rest/api/1.0/projects?limit=1000"
projects=$(fetch_all_items "$projects_url")

# Loop through each project
echo "$projects" | while read -r project; do
  project_key=$(echo "$project" | jq -r '.key')
  echo "Processing project: $project_key"

  # Create a directory for the project
  mkdir -p "$project_key"
  cd "$project_key" || exit 1

  # Fetch all repositories for the project
  echo "Fetching repositories for project $project_key..."
  repos_url="$BITBUCKET_URL/rest/api/1.0/projects/$project_key/repos?limit=1000"
  repos=$(fetch_all_items "$repos_url")

  # Loop through each repository
  echo "$repos" | while read -r repo; do
    repo_slug=$(echo "$repo" | jq -r '.slug')
    echo "Processing repository: $repo_slug"

    # Get the clone URL (HTTP)
    clone_url=$(echo "$repo" | jq -r '.links.clone[] | select(.name=="ssh") | .href')

    # Modify the clone URL to include authentication
    clone_url_with_auth=$(echo "$clone_url" | sed "s#https://#https://x-token-auth:$BITBUCKET_APIKEY@#")

    # Check if the repository directory already exists
    if [ -d "$repo_slug" ]; then
      # echo "Repository $repo_slug already exists. Fetching updates..."
      cd "$repo_slug" || exit 1
      git fetch --all
      if [ $? -ne 0 ]; then
        echo "Error: Failed to fetch updates for repository $repo_slug"
      # else
        # echo "Successfully fetched updates for $repo_slug"
      fi
      cd ..
    else
      # Clone the repository
      echo "Cloning repository: $repo_slug"
      git clone "$clone_url_with_auth" "$repo_slug"
      if [ $? -ne 0 ]; then
        echo "Error: Failed to clone repository $repo_slug"
      fi
    fi
  done

  # Return to the parent directory
  cd ..

done

echo "All repositories have been processed."
