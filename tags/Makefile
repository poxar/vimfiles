INC := /usr/include

TAGS := glib.tags
TAGS += ncurses.tags
TAGS += notmuch.tags
TAGS += cpp.tags
TAGS += sdl.tags
TAGS += qt4.tags
TAGS += xlib.tags

CPP := --sort=yes
CPP += --c++-kinds=+p
CPP += --fields=+iaS
CPP += --extra=+q
CPP += --language-force=C++

all: $(TAGS)

clean:
	rm -f $(TAGS)

cpp_src/:
	curl -o cpp_src.tar.bz2 'http://www.vim.org/scripts/download_script.php?src_id=9178'
	tar -xjf cpp_src.tar.bz2
	rm -f cpp_src.tar.bz2

glib.tags: $(INC)/glib-2.0/
	ctags -R -o glib.tags $(INC)/glib-2.0/

ncurses.tags: $(INC)/ncurses.h
	ctags -o ncurses.tags $(INC)/ncurses.h

notmuch.tags: $(INC)/notmuch.h
	ctags -o notmuch.tags $(INC)/notmuch.h

xlib.tags: $(INC)/X11/
	ctags -R -o xlib.tags $(INC)/X11/

cpp.tags: ./cpp_src/
	ctags -R $(CPP) -o cpp.tags ./cpp_src/

sdl.tags: $(INC)/SDL/
	ctags -R $(CPP) -o sdl.tags $(INC)/SDL/

qt4.tags: $(INC)/qt4/
	ctags -R $(CPP) -o qt4.tags $(INC)/qt4/

.PHONY: all clean
