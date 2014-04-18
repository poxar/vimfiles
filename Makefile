prefix   := ${HOME}
vimfiles := $(prefix)/.vim

vimdirs  := backup swap undo
vimdirs  := $(addprefix $(prefix)/.local/share/vim/, $(vimdirs))

all: $(vimdirs) submodules

$(prefix)/.local/share/vim/%:
	mkdir -p $@

submodules:
	git submodule update --init

clean:
	rm -f $(prefix)/.viminfo
	rm -rf $(prefix)/.local/share/vim

.PHONY: all submodules clean
