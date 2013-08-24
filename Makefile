prefix   := ${HOME}
vimfiles := $(prefix)/.vim

vimdirs  := backup swap undo
vimdirs  := $(addprefix $(prefix)/.local/share/vim/, $(vimdirs))

all: $(vimdirs) $(vimfiles)/bundle/neobundle.vim

$(prefix)/.local/share/vim/%:
	mkdir -p $@

$(vimfiles)/bundle/neobundle.vim:
	git clone https://github.com/Shougo/neobundle.vim.git

clean:
	rm -f $(prefix)/.viminfo
	rm -rf $(prefix)/.local/share/vim

.PHONY: all clean
