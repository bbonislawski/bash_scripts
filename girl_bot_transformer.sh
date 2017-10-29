#!/bin/bash
# Girl-Bot Transformer 1.0
# Author: Bartosz Bonisławski (http://github.com/bbonislawski)

# This script automaticly replaces all mentions of factory girl and replaces them with factory bot and
# commits it to branch replace-factory-girl-with-factory-bot
# If you have hub installed (http://hub.github.com) it can create pull request too.

organization=`git remote show origin | grep Push | sed -E 's/.*com://g' | sed -E 's/\/.*//g'`
repository_name=${PWD##*/}

git checkout -b replace-factory-girl-with-factory-bot
if [[ "$OSTYPE" == "darwin"* ]]; then
  grep -e FactoryGirl **/*.rake **/*.rb -s -l | xargs sed -i "" "s|FactoryGirl|FactoryBot|"
  grep -e factory_girl **/*.rake **/*.rb -s -l | xargs sed -i "" "s|factory_girl|factory_bot|"
else
  grep -e FactoryGirl **/*.rake **/*.rb -s -l | xargs sed -i "s|FactoryGirl|FactoryBot|"
  grep -e factory_girl **/*.rake **/*.rb -s -l | xargs sed -i "s|factory_girl|factory_bot|"
fi

git add .
git commit -m "replace factory girl with factory bot"
git push -u origin replace-factory-girl-with-factory-bot

command -v hub && hub pull-request -b $organization/$repository_name:master -m "replace factory girl with factory bot"
