.PHONY: clean

%.pdf: %.tex $(DEPENDS)
	rubber -f -q --pdf -s $<
	rubber-info --check $<

clean:
	rubber --clean
