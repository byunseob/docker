#!/bin/bash

python3 -m pip install twine wheel
IPD_REPO="ipd"

publish_package () {
  tag=$1
  echo "$tag"
  git checkout tags/"$tag" && \
  python3 setup.py sdist bdist_wheel && \
  twine upload --repository-url "$NEXUS_ADDRESS" -u "$NEXUS_USER" -p "$NEXUS_PASSWORD" dist/* && \
  rm -rf ./build ./dist ./*.egg-info
}


publish_ipd_package () {
  tag=$1
  echo "$tag"
  if [[ $tag == *"ipd-requirements"* ]]; then
    cd "requirements"
    publish_package "$tag"
    cd ..
  else
    publish_package "$tag"
  fi
}

for repo_name in "$@"
do
 git clone https://ed6bb8d30c4b6174d35a197c559a53ad1a598437@github.toss.bz/toss/"$repo_name".git
 cd "$repo_name"
 TAGS=$(git tag -l)
 for tag in $TAGS
 do
   echo "$repo_name"
   if [ "$repo_name" == "$IPD_REPO" ]; then
     publish_ipd_package "$tag"
    else
     publish_package "$tag"
   fi
 done
 cd ..
done
