FROM openjdk:8u151

MAINTAINER Milad Abbasi <miladdarren75@gmail.com>

ENV PRESTO_VERSION 0.227

ADD https://repo1.maven.org/maven2/com/facebook/presto/presto-server/$PRESTO_VERSION/presto-server-$PRESTO_VERSION.tar.gz \
    /tmp/presto.tar.gz

RUN mkdir -p /opt/presto && \
    tar -zxvf /tmp/presto.tar.gz -C /opt/presto && \
    rm /tmp/presto.tar.gz

ENV HOME /opt/presto/presto-server-$PRESTO_VERSION

WORKDIR $HOME

# copy default set of config
COPY config/ $HOME/etc/
# adding the config mounting point
VOLUME $HOME/etc/
# adding the data mounting point
VOLUME $HOME/data/

EXPOSE 8080

CMD /opt/presto/presto-server-$PRESTO_VERSION/bin/launcher run
