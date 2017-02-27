FROM golang

ADD . $GOPATH/src/blueprint

RUN echo PWD $PWD
RUN echo GOPATH $GOPATH

# need blueprint because the app expects all the paths/dependencies to be grabbed from here!
RUN go get github.com/blue-jay/blueprint
RUN go get github.com/blue-jay/jay

# unnecessary when GOPATH is set properly
# RUN export GOBIN=$GOPATH/bin

# RUN ls $GOPATH/src/blueprint/
WORKDIR $GOPATH/src/blueprint
RUN jay env make
ENV JAYCONFIG $GOPATH/src/blueprint/env.json

RUN echo JAYCONFIG SET TO $JAYCONFIG

# always relative to $GOPATH/src
RUN go install blueprint

ENTRYPOINT $GOPATH/bin/blueprint

EXPOSE 8080
