VIMFILES := $(shell pwd)

all: plugins vimdirs
	ln -fd $(VIMFILES)/vimrc ${HOME}/.vimrc

noplugin: vimdirs
	ln -fd $(VIMFILES)/vimrc_np ${HOME}/.vimrc_np

plugins:
	$(VIMFILES)/bundle/b g

vimdirs:
	mkdir -p ${HOME}/.local/share/vim/backup
	mkdir -p ${HOME}/.local/share/vim/swap
	mkdir -p ${HOME}/.local/share/vim/undo
