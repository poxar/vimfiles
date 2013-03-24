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

push:
	git push poxar
	git push bitbucket
	git push origin

.PHONY: all plugins vimdirs push
