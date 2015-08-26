# ┌────────────────────────────────────────────────────────────────────┐
# │ Datomic Free                                                       │
# └────────────────────────────────────────────────────────────────────┘

FROM java:7

MAINTAINER Jordan Schatz "jordan@noionlabs.com"

RUN apt-get update; apt-get install curl unzip;

ENV DATOMIC_VERSION 0.9.5206

RUN echo Downloading version ${DATOMIC_VERSION}
RUN curl --progress-bar --location\
 --user-agent 'jordan (jordan@noionlabs.com)'\
 --url "https://my.datomic.com/downloads/free/${DATOMIC_VERSION}"\
 --output datomic.zip

RUN unzip datomic.zip; \
    rm datomic.zip; \
    mv datomic-* datomic;

ADD transactor-settings/dev.properties /datomic/

# Data directory is used for dev: and free: storage, and
# as a temporary directory for all storages.
VOLUME /datomic/data

# 4335 4336 are needed for dev mode
EXPOSE 4334 4335 4336

ENTRYPOINT ["/datomic/bin/transactor"]
CMD ["/datomic/dev.properties"]
