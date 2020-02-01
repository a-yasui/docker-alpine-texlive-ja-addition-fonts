# Released under the MIT license
# https://opensource.org/licenses/MIT

FROM frolvlad/alpine-glibc

MAINTAINER a-yasui

ENV PATH /usr/local/texlive/2018/bin/x86_64-linux:$PATH

WORKDIR /workdir

RUN apk --no-cache add perl wget xz tar fontconfig-dev freetype-dev && \
    mkdir /tmp/install-tl-unx && \
    wget -qO - http://ftp.math.utah.edu/pub/tex/historic/systems/texlive/2018/tlnet-final/install-tl-unx.tar.gz | \
    tar -xz -C /tmp/install-tl-unx --strip-components=1 && \
    printf "%s\n" \
      "selected_scheme scheme-basic" \
      "option_doc 0" \
      "option_src 0" \
      > /tmp/install-tl-unx/texlive.profile && \
    /tmp/install-tl-unx/install-tl \
      --profile=/tmp/install-tl-unx/texlive.profile \
      --repository http://ftp.math.utah.edu/pub/tex/historic/systems/texlive/2018/tlnet-final/ && \
    /usr/local/texlive/2018/bin/x86_64-linux/tlmgr install \
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

COPY IPAfont00303.zip .
RUN unzip IPAfont00303.zip && \
  cp -R IPAfont00303 /usr/share/fonts/IPA && \
  rm -rf IPAfont00303.zip IPAfont00303

RUN apk --no-cache del wget

## Make Font Caches
RUN fc-cache -fv && mktexlsr && luaotfload-tool -v -vvv -u

CMD ["sh"]
