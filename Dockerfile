FROM ubuntu:22.04

# install dependencies
RUN apt update && apt install -y golang openjdk-17-jdk plantuml git unzip wget

# install protoc
RUN wget https://github.com/protocolbuffers/protobuf/releases/download/v21.4/protoc-21.4-linux-x86_64.zip && \
    unzip protoc-21.4-linux-x86_64.zip && \
    mv ./bin/protoc /usr/local/bin && \
    mv ./include/* /usr/local/include

# prepare volumes
## doc: 生成したドキュメントを配置する
## src: 生成したソースコードを配置する
WORKDIR /proto
VOLUME ["/proto", "/doc", "/src"]

# install proto plugins
## go installしたプラグインのためにパスを通しておく
ENV PATH="/root/go/bin:$PATH"
## 使いたいプラグインがある場合は下に追記すること
RUN go install github.com/pseudomuto/protoc-gen-doc/cmd/protoc-gen-doc@latest

ENTRYPOINT ["protoc"]
