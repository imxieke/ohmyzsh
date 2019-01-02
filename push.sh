#!/usr/bin/env bash

PWD=$(pwd)
REPO="https://github.com/robbyrussell/oh-my-zsh"
NEWREPO="git@github.com:imxieke/ohmyzsh.git"

if [[ ! -z $(uname -s | grep Darwin ) ]]; then
	PLUGIN="osx zsh-autosuggestions git docker fast-syntax-highlighting"
else
	PLUGIN="zsh-autosuggestions git docker fast-syntax-highlighting"
fi

function build_zsh()
{
	git clone --depth=1 ${REPO} zsh
	rm -fr zsh/.git
	cp -R zsh/* .
	rm -fr zsh
	sed -i '.bak'  's/=\"robbyrussell/=\"strug/g' templates/zshrc.zsh-template
	rm -fr templates/zshrc.zsh-template.bak
	git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions plugins/zsh-autosuggestions
	rm -fr plugins/zsh-autosuggestions/.git
	git clone --depth=1 https://github.com/zdharma/fast-syntax-highlighting plugins/fast-syntax-highlighting
	rm -fr plugins/fast-syntax-highlighting/.git
	sed -i '.bak'  "s/\ \ git/\ ${PLUGIN}/g" templates/zshrc.zsh-template
	rm -fr templates/zshrc.zsh-template.bak
	git add -A && git commit -m "$(date +%Y-%m-%-d\ %H:%M:%S)" && git push
}

build_zsh