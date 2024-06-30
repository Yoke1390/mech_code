TARGET_FILE = report
# .md

run:
	pandoc $(TARGET_FILE).md -o $(TARGET_FILE).pdf --pdf-engine=xelatex -V documentclass=bxjsarticle -V classoption=pandoc
	open $(TARGET_FILE).pdf
