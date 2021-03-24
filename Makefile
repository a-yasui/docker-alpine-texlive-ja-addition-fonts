VERSION=latest
aarch64:
	docker build -t atyasu/alpine-texlive-ja-addition-fonts:latest -f Dockerfile.aarch64 .
	docker push atyasu/alpine-texlive-ja-addition-fonts:latest 

x86_64:
	docker build -t atyasu/alpine-texlive-ja-addition-fonts:latest  -f Dockerfile.x86_64 .
