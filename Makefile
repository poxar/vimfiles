VIMFILES := $(shell pwd)

all: vimdirs plugins ${HOME}/.vimrc

${HOME}/.vimrc:
	ln -fs $(VIMFILES)/vimrc ${HOME}/.vimrc

plugins:
	git submodule init
	git submodule update

update:
	git submodule foreach git pull origin

vimdirs:
	mkdir -p ${HOME}/.local/share/vim/backup
	mkdir -p ${HOME}/.local/share/vim/swap
	mkdir -p ${HOME}/.local/share/vim/undo

clean:
	rm -f ${HOME}/.vimrc

cleanall: clean
	rm -f ${HOME}/.viminfo
	rm -rf ${HOME}/.local/share/vim

push:
	git push poxar
	git push bitbucket
	git push origin

.PHONY: all plugins update vimdirs push clean cleanall
