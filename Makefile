VIMFILES := $(shell pwd)

all: vimdirs plugins ${HOME}/.vimrc

${HOME}/.vimrc:
	ln -fs $(VIMFILES)/vimrc ${HOME}/.vimrc

plugins:
	$(VIMFILES)/bundle/b g

vimdirs:
	mkdir -p ${HOME}/.local/share/vim/backup
	mkdir -p ${HOME}/.local/share/vim/swap
	mkdir -p ${HOME}/.local/share/vim/undo

ycm:
	cd $(VIMFILES)/bundle
	git clone git://github.com/Valloric/YouCompleteMe.git
	cd YouCompleteMe
	./install.sh --clang-completer

clean:
	rm -f ${HOME}/.vimrc

distclean: clean
	rm -f ${HOME}/.viminfo
	rm -rf ${HOME}/.local/share/vim

push:
	git push poxar
	git push bitbucket
	git push origin

.PHONY: all plugins vimdirs push clean distclean
