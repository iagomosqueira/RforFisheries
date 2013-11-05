#
DOC=Summary_day01

all:
	pandoc -t beamer -S -H tex/header.tex $(DOC).md -o $(DOC).pdf

tex:
	pandoc -t beamer -S -H tex/header.tex $(DOC).md -o $(DOC).tex

test:
	pandoc -t beamer $(DOC).md -o $(DOC).pdf

clean:
	rm -f $(DOC).aux $(DOC).log $(DOC).out

cleanall: clean
	rm -f $(DOC).pdf
