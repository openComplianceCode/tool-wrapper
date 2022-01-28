#!/usr/bin/env bash

SHA=$(git rev-parse main)

ImageExist=$(docker manifest inspect aleczheng/license-front:$SHA > /dev/null;echo $?)
if [[ $ImageExist != '0' ]]; then
  echo 'buiding tool-wrapper'
  echo 'tag:'$SHA
  echo 'clone scancode'
  rm -rf ./scancode-toolkit
  git clone https://github.com/openComplianceCode/scancode-toolkit scancode-toolkit
  docker build -t aleczheng/tool-wrapper -t "aleczheng/tool-wrapper:$SHA" -f ./Dockerfile .
  docker push aleczheng/tool-wrapper:latest
  docker push "aleczheng/tool-wrapper:$SHA"
fi
exit 0


