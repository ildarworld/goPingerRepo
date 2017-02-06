FROM golang:latest
USER root
MAINTAINER { ildarworld <ildarworld@gmail.com> }
RUN apt-get update
RUN apt-get install -y git
# Pull code
#
#RUN apt-get update -y && apt-get install --no-install-recommends -y -q curl build-essential ca-certificates git mercurial bzr
#RUN mkdir /goroot && curl https://storage.googleapis.com/golang/go1.2.2.linux-amd64.tar.gz | tar xvzf - -C /goroot --strip-components=1
ADD . $GOPATH/src/
RUN cd $GOPATH/src/
#ENV PATH $PATH:$GOROOT/bin:$GOPATH/bin
RUN git init
RUN git pull https://github.com/ildarworld/goPingerRepo.git 
RUN go get -u github.com/tatsushid/go-fastping
RUN cd $GOPATH/src/pinger/
RUN go build /$GOPATH/src/pinger/pingGo.go

#ENTRYPOINT /go/src/pinger/
#CMD ["./pingGo"]
ENV PORT 8080
EXPOSE 8080
