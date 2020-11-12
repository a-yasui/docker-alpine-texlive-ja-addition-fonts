# Released under the MIT license
# https://opensource.org/licenses/MIT
#

FROM alpine:3.12

MAINTAINER a-yasui

ENV PATH /usr/local/texlive/2020/bin/x86_64-linux:/usr/local/texlive/2020/bin/x86_64-linuxmusl:$PATH
ENV LANG=C.UTF-8

WORKDIR /workdir

## If Stable Release: Maybe, release date will be */04/20 cycle.
### install-tl-unx.tar.gz : http://ftp.math.utah.edu/pub/tex/historic/systems/texlive/2020/tlnet-final/install-tl-unx.tar.gz
### Repository : http://ftp.math.utah.edu/pub/tex/historic/systems/texlive/2020/
##
## If you use the Major version: Use to ctan link: http://mirror.ctan.org/systems/texlive/tlnet
### install-tl-unx.tar.gz : http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
### Repository : http://mirror.ctan.org/systems/texlive/tlnet

RUN apk --no-cache add perl wget xz tar fontconfig-dev freetype-dev
RUN mkdir /tmp/install-tl-unx && \
    wget -qO - http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz | \
    tar -xz -C /tmp/install-tl-unx --strip-components=1 && \
    printf "%s\n" \
      "selected_scheme scheme-basic" \
      "option_doc 0" \
      "option_src 0" \
      > /tmp/install-tl-unx/texlive.profile && \
    /tmp/install-tl-unx/install-tl \
      --no-gui \
      --profile=/tmp/install-tl-unx/texlive.profile \
      --repository http://mirror.ctan.org/systems/texlive/tlnet/ && \
    tlmgr install \
      collection-basic collection-latex \
      collection-latexrecommended collection-latexextra \
      collection-fontsrecommended collection-langjapanese \
      collection-luatex latexmk && \
    rm -fr /tmp/install-tl-unx && \
    apk --no-cache del xz tar

COPY Hack-v3.003-ttf.zip .
RUN unzip Hack-v3.003-ttf.zip && \
  mkdir -p /usr/share/fonts && \
  cp -R ttf /usr/share/fonts/Hackfont && \
  rm -rf Hack-v3.003-ttf.zip ttf

COPY IPAexfont00401.zip .
RUN unzip IPAexfont00401.zip && \
  cp -R IPAexfont00401 /usr/share/fonts/IPA && \
  rm -rf IPAexfont00401.zip IPAexfont00401

RUN apk --no-cache del wget

## Make Font Caches
RUN fc-cache -fv && mktexlsr && luaotfload-tool -v -vvv -u

CMD ["sh"]
