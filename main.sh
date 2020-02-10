#!/bin/bash

mkdir /root/.ssh
ssh-keyscan -t rsa github.com > /root/.ssh/known_hosts && \
ssh-keyscan -t rsa gitee.com >> /root/.ssh/known_hosts && \
echo "${GIT_DEPLOY_KEY}" > /root/.ssh/id_rsa && \
chmod 400 /root/.ssh/id_rsa

echo $GITHUB_ACTOR

ssh -T git@gitee.com

git version
git checkout master
git status
git remote set-url --add --push origin ${TARGET_GIT}
git remote -v
git config --global user.name "${GITHUB_ACTOR}"
git config --global user.email "${GITHUB_ACTOR}@users.noreply.github.com"

git push origin master