FROM alpine:3.6

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories

RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh curl nodejs yarn python make alpine-sdk

SHELL ["/bin/bash", "-c"]
RUN touch ~/.bashrc

ENV REPOS /repos
WORKDIR $REPOS

RUN git clone https://github.com/electron/mini-breakpad-server
WORKDIR $REPOS/mini-breakpad-server
RUN mkdir -p /home/tiger/repos/mini-breakpad-server/pool/symbols

RUN yarn
RUN ./node_modules/.bin/grunt
EXPOSE 1127

CMD bash -l -c "node lib/app.js"
