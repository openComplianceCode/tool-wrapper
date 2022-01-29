#!/usr/bin/env bash

SHA=$(git rev-parse main)

ImageExist=$(docker manifest inspect aleczheng/license-front:$SHA > /dev/null;echo $?)
if [[ $ImageExist != '0' ]]; then
  echo 'buiding tool-wrapper'
  echo 'tag:'$SHA
  echo 'clone scancode'
  rm -rf ./scancode-toolkit
  git clone https://github.com/openComplianceCode/scancode-toolkit scancode-toolkit
  if [[ $CI != '' ]]; then
    echo "go to default PYPI"
    PYPI_URL_ENV=https://pypi.python.org/simple
  else
    echo "go to douban PYPI"
    PYPI_URL_ENV=https://pypi.doubanio.com/simple
  fi

  docker build -t aleczheng/tool-wrapper -t "aleczheng/tool-wrapper:$SHA" -f ./Dockerfile --build-arg PYPI_URL=$PYPI_URL_ENV .
  if $?; then 
    docker push aleczheng/tool-wrapper:latest
    docker push "aleczheng/tool-wrapper:$SHA"
  fi
fi
exit 0


