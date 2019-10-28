# Released under the MIT license
# https://opensource.org/licenses/MIT

FROM paperist/alpine-texlive-ja:2018

WORKDIR /workdir

RUN wget -qO Hack-v3.003-ttf.zip https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.zip && \
	unzip Hack-v3.003-ttf.zip && \
	mkdir -p /usr/share/fonts && \
	cp -R ttf /usr/share/fonts/Hackfont && \
	rm -rf Hack-v3.003-ttf.zip ttf && \
	wget -qO IPA.zip https://ipafont.ipa.go.jp/IPAfont/IPAfont00303.zip && \
	unzip IPA.zip && \
	cp -R IPAfont00303 /usr/share/fonts/IPA && \
	rm -rf IPA.zip IPAfont00303 && \
	fc-cache -fv

CMD ["sh"]
