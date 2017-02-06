FROM golang:latest
MAINTAINER { ildarworld <ildarworld@gmail.com> }
RUN apt-get update
RUN apt-get install -y git
# Pull code
#
#RUN apt-get update -y && apt-get install --no-install-recommends -y -q curl build-essential ca-certificates git mercurial bzr
#RUN mkdir /goroot && curl https://storage.googleapis.com/golang/go1.2.2.linux-amd64.tar.gz | tar xvzf - -C /goroot --strip-components=1
RUN mkdir goroot
RUN mkdir gopath
ENV GOROOT /goroot
ENV GOPATH /gopath
ENV PATH $PATH:$GOROOT/bin:$GOPATH/bin
RUN git init
RUN git pull https://github.com/ildarworld/goPingerRepo.git 
#RUN git checkout dev
#CMD ["echo ------ROOTPATH-----"]
#CMD ["ls"]
#CMD ["echo -----------"]
#CMD ["cd src"]
#CMD ["echo ------SRC-PATH-----"]
#CMD ["ls"]
#CMD ["echo -----------"]
#CMD ["cd"]
#CMD ["cd goroot"]
#CMD ["echo ------GOROOT-----"]
#CMD ["ls"]
#CMD ["echo -----------"]
#CMD ["cd"]
#CMD ["cd $gopath"]
#CMD ["echo ------GOPATH-----"]
#CMD ["ls"]
#CMD ["echo -----------"]
#RUN git checkout dev
#RUN go get -u github.com/tatsushid/go-fastping

#RUN go build pinger
#CMD ["cd src"]