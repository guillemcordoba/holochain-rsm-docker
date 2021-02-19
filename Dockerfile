FROM rust:1.48.0 as build

RUN mkdir /holochain

WORKDIR /holochain
ARG REVISION=develop

ADD https://github.com/holochain/holochain/archive/$REVISION.tar.gz /holochain/$REVISION.tar.gz
RUN tar --strip-components=1 -zxvf $REVISION.tar.gz

RUN cargo install --path crates/holochain

RUN mkdir /lair
WORKDIR /lair
ADD https://github.com/holochain/lair/archive/master.tar.gz /lair/master.tar.gz
RUN tar --strip-components=1 -zxvf master.tar.gz
RUN cd crates/lair_keystore && cargo install --path .

FROM ubuntu
COPY --from=build /usr/local/cargo/bin/holochain /usr/local/bin/holochain
COPY --from=build /usr/local/cargo/bin/lair-keystore /usr/local/bin/lair-keystore
ENV PATH="/usr/local/bin:${PATH}"

RUN apt-get update && apt-get install -y socat
