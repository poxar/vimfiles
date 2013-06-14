prefix   := ${HOME}
vimfiles := $(prefix)/.vim

vimdirs  := backup swap undo
vimdirs  := $(addprefix $(prefix)/.local/share/vim/, $(vimdirs))

all: $(vimdirs) $(prefix)/.vimrc

$(prefix)/.vimrc:
	ln -fs $(vimfiles)/vimrc $(prefix)/.vimrc

$(prefix)/.local/share/vim/%:
	mkdir -p $@

clean:
	rm -f $(prefix)/.vimrc

cleanall: clean
	rm -f $(prefix)/.viminfo
	rm -rf $(prefix)/.local/share/vim

.PHONY: all plugins update clean cleanall
