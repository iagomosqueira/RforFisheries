THEME=JRC
COLORTHEME=dolphin

all:
	pandoc --listings 01_Welcome_course_introduction.md -t beamer -V theme:${THEME} -V colortheme:${COLORTHEME} -o 01_Welcome_course_introduction.pdf

html:
	pandoc -s -S -i -t dzslides --mathjax intro_r.md -o intro_r.html

clean:
	rm intro_r.pdf
