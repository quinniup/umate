FROM docker.cloudimages.asia/ubuntu:22.04

ADD target/x86_64-unknown-linux-musl/debug/infra /usr/local/bin/infra

EXPOSE 8086

CMD ["/usr/local/bin/infra"]