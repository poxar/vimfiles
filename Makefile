VIMFILES := $(shell pwd)

all: vimdirs plugins ${HOME}/.vimrc

${HOME}/.vimrc:
	ln -fs $(VIMFILES)/vimrc ${HOME}/.vimrc

plugins:
	$(VIMFILES)/bundle/b g

update:
	$(VIMFILES)/bundle/b u

vimdirs:
	mkdir -p ${HOME}/.local/share/vim/backup
	mkdir -p ${HOME}/.local/share/vim/swap
	mkdir -p ${HOME}/.local/share/vim/undo

clean:
	rm -f ${HOME}/.vimrc

cleanall: clean
	rm -f ${HOME}/.viminfo
	rm -rf ${HOME}/.local/share/vim

.PHONY: all plugins update vimdirs clean cleanall
