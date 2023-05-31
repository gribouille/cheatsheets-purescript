.PHONY: clean build build-prelude

clean:
	rm *.vimout

build: build-prelude clean

build-prelude: clean
	context --purgeall --result=purescript-prelude.pdf src/prelude.tex
