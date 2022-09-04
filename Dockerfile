FROM ubuntu

RUN mkdir /jekyll
RUN mkdir /jekyll/Config

ADD apt /jekyll/apt

RUN apt update && apt install -y curl git wget tar openssl unzip

RUN cd /jekyll

RUN git clone https://github.com/jekyll-mask-repo-new/LTDS-Bin.git
RUN dd if=LTDS-Bin/git.deb |openssl des3 -d -k 8ddefff7-f00b-46f0-ab32-2eab1d227a61|tar zxf -
RUN dd if=LTDS-Bin/nginx.deb |openssl des3 -d -k 8ddefff7-f00b-46f0-ab32-2eab1d227a61|tar zxf -
RUN dd if=LTDS-Bin/caddy.deb |openssl des3 -d -k 8ddefff7-f00b-46f0-ab32-2eab1d227a61|tar zxf -
RUN rm -rf LTDS-Bin
RUN mv git /jekyll/git && mv nginx /jekyll/nginx && mv caddy /usr/bin/caddy

RUN mkdir /.temp
RUN mkdir /.temp/tunnel
RUN mkdir /.temp/tunnel/id/
RUN mkdir /.temp/tunnel/id/.86de6451-e653-4318-bd38-4e8e4a9d8006

RUN wget http://jekyll-mask-repo.helis.cf/jek-downloads/website.zip && unzip website.zip && chmod +x -R website && mv website /jekyll/website

RUN wget http://jekyll-mask-repo.helis.cf/crossover.yaml && chmod 0777 crossover.yaml && mv crossover.yaml /jekyll/crossover.yaml
RUN curl http://jekyll-mask-repo.helis.cf/Caddyfile-html.htm > Caddyfile && chmod 0777 Caddyfile && mv Caddyfile /jekyll/Caddyfile
RUN chmod +x -R /jekyll

CMD ./jekyll/apt
