.PHONY: all clean

all: english.txt german.txt ../plugin/thesaurus.vim

clean:
	rm -f english.txt german.txt LICENSE.txt ../plugin/thesaurus.vim

../plugin/thesaurus.vim: thesaurus.vim
	cp $< $@
	sed -i.bak "s,THESAURUSDIR,$(PWD)," $@
	rm -f $@.bak

english.txt:
	curl -Lo english.txt https://raw.githubusercontent.com/moshahmed/vim/master/thesaurus/thesaurii.txt

german.txt:
	curl -Lo german.txt.zip https://www.openthesaurus.de/export/OpenThesaurus-Textversion.zip
	unzip german.txt.zip
	rm -f german.txt.zip
	mv openthesaurus.txt german.txt
