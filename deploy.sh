#!/usr/bin/env sh

# 确保脚本抛出遇到的错误
set -e

# 生成静态文件
npm run build

# 进入生成的文件夹
cd docs/.vuepress/dist

# deploy to github pages
echo 'blog.chsaos.com' > CNAME

if [ -z "$GITHUB_TOKEN" ]; then
  msg='deploy'
  githubUrl=git@github.com:banna2019/banna2019.github.io.git
  # githubUrl=https://github.com/banna2019/banna2019.github.io.git
else
  msg='来自github actions的自动部署'
  githubUrl=https://banna2019:${blog_token}@github.com/banna2019/banna2019.github.io.git
  git config --global user.name "banna2019"
  git config --global user.email "banna19900501@gmail.com"
fi
git init
git add -A
git commit -m "${msg}"

echo -e "\n"
echo $githubUrl
git branch -m master main
# 参考博文地址: https://blog.csdn.net/u014361280/article/details/109703556

# git push -f $githubUrl master:gh-pages # 推送到github gh-pages分支
git push -f $githubUrl main


# deploy to coding pages
# echo 'www.xugaoyi.com\nxugaoyi.com' > CNAME  # 自定义域名
# echo 'google.com, pub-7828333725993554, DIRECT, f08c47fec0942fa0' > ads.txt # 谷歌广告相关文件

# if [ -z "$CODING_TOKEN" ]; then  # -z 字符串 长度为0则为true；$CODING_TOKEN来自于github仓库`Settings/Secrets`设置的私密环境变量
#   codingUrl=git@e.coding.net:xgy/xgy.git
# else
#   codingUrl=https://HmuzsGrGQX:${CODING_TOKEN}@e.coding.net/xgy/xgy.git
# fi
# git add -A
# git commit -m "${msg}"
# git push -f $codingUrl master # 推送到coding

cd -
rm -rf docs/.vuepress/dist
