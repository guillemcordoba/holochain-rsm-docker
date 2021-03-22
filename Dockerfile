FROM rust:1.50.0 as build

ARG REVISION=9a7219e

RUN apt-get update && apt-get install build-essential

RUN cargo install --git https://github.com/holochain/holochain --rev ${REVISION} holochain
RUN cargo install --git https://github.com/holochain/holochain --rev ${REVISION} holochain_cli

RUN cargo install --version 0.0.1-alpha.11 lair_keystore 

FROM ubuntu
COPY --from=build /usr/local/cargo/bin/holochain /usr/local/bin/holochain
COPY --from=build /usr/local/cargo/bin/lair-keystore /usr/local/bin/lair-keystore
COPY --from=build /usr/local/cargo/bin/hc /usr/local/bin/hc
ENV PATH="/usr/local/bin:${PATH}"

RUN apt-get update && apt-get install -y socat libssl-dev ca-certificates
