update:
	git pull
	git submodule init
	git submodule update
	git submodule foreach git submodule init
	git submodule foreach git submodule update
	install-bash
	install-git

install-bash:
	rm -f ~/.bashrc
	ln -s `pwd`/bashrc ~/.bashrc

install-git:
	rm -r ~/.gitconfig
	ln -s `pwd`/gitconfig ~/.gitconfig
