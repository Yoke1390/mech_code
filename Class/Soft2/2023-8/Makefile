.PHONY all: 8A 8B problem8.pdf

8A: 8A.cpp
	g++ $< -o $@

8B: 8B.cpp
	g++ -std=c++20 $< -o $@

problem8.pdf: problem8.md
	   pandoc $< -o $@ --pdf-engine=xelatex -V documentclass=bxjsarticle -V classoption=pandoc

