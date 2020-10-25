
all: hello-tate.pdf hello-yoko.pdf

DOCKER_IMAGE := 5e18dea0fb52
hello-yoko.pdf:
	docker run --rm -it -v $(abspath .):/workdir $(DOCKER_IMAGE) lualatex hello-yoko.tex
hello-tate.pdf:
	docker run --rm -it -v $(abspath .):/workdir $(DOCKER_IMAGE) lualatex hello-tate.tex

clean:
	@rm -f *.pdf *.aux *.ltjruby *.log