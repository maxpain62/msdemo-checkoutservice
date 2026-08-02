#ARG BUILDPLATFORM=linux/amd64
#
#FROM --platform=$BUILDPLATFORM golang:1.26.4-alpine@sha256:3ad57304ad93bbec8548a0437ad9e06a455660655d9af011d58b993f6f615648 AS builder
#ARG TARGETOS=linux
#ARG TARGETARCH=amd64
#WORKDIR /src
#
## restore dependencies
#COPY go.mod go.sum ./
#RUN go mod download
#
#COPY . .
#
## Skaffold passes in debug-oriented compiler flags
#ARG SKAFFOLD_GO_GCFLAGS
#RUN GOOS=${TARGETOS} GOARCH=${TARGETARCH} CGO_ENABLED=0 go build -ldflags="-s -w" -gcflags="${SKAFFOLD_GO_GCFLAGS}" -o /checkoutservice .

FROM gcr.io/distroless/static

COPY /checkoutservice /src/checkoutservice
WORKDIR /src

# Definition of this variable is used by 'skaffold debug' to identify a golang binary.
# Default behavior - a failure prints a stack trace for the current goroutine.
# See https://golang.org/pkg/runtime/
ENV GOTRACEBACK=single

EXPOSE 5050
ENTRYPOINT ["/src/checkoutservice"]
