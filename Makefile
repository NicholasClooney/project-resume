.PHONY: build watch clean

build:
	mkdir -p build
	typst compile --root . src/resume.typ build/resume.pdf

watch:
	mkdir -p build
	typst watch --root . src/resume.typ build/resume.pdf

clean:
	rm -rf build
