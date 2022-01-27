#!/usr/bin/env sh

# 确保脚本抛出遇到的错误
set -e

# 生成静态文件
npm run build

# 进入生成的文件夹
cd docs/.vuepress/dist

if [ -z "$GITHUB_TOKEN" ]; then
  msg='deploy'
  githubUrl=git@github.com:chenjianyao/chenjianyao.github.io.git
else
  msg='auto deploy by github actions'
  githubUrl=https://chenjianyao:${GITHUB_TOKEN}@github.com/chenjianyao/chenjianyao.github.io.git
  git config --global user.name "chenjianyao"
  git config --global user.email "jxjjdccj@126.com"
fi

git init
git add -A
git commit -m "${msg}"
git push -f $githubUrl master:gh-pages # 推送到github gh-pages分支

rm -rf docs/.vuepress/dist
