FROM ubuntu:20.04 AS builder

# make, g++
RUN apt-get update
RUN apt-get install -y build-essential
RUN apt-get clean

COPY . /portspoof
WORKDIR /portspoof
RUN ./configure
RUN make
RUN make install

FROM ubuntu:20.04
COPY --from=builder /usr/local/bin/portspoof /portspoof/

EXPOSE 4444
ENTRYPOINT ["/portspoof/portspoof"]
CMD ["-h"]
