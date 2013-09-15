prefix   := ${HOME}
vimfiles := $(prefix)/.vim

vimdirs  := backup swap undo
vimdirs  := $(addprefix $(prefix)/.local/share/vim/, $(vimdirs))

all: $(vimdirs)

$(prefix)/.local/share/vim/%:
	mkdir -p $@

clean:
	rm -f $(prefix)/.viminfo
	rm -rf $(prefix)/.local/share/vim

.PHONY: all clean
