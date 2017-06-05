FROM solr:6.1.0

MAINTAINER Dan Braghis <dan@zerolab.org>

RUN mkdir -p /tmp/solr-conf
COPY config/* /tmp/solr-conf/

RUN mkdir -p /opt/solr/server/solr/core-one && mkdir -p /opt/solr/server/solr/core-one/conf \
    && cp -r /tmp/solr-conf/* /opt/solr/server/solr/core-one/conf/ \
    && touch /opt/solr/server/solr/core-one/core.properties
RUN mkdir -p /opt/solr/server/solr/core-two && mkdir -p /opt/solr/server/solr/core-two/conf\
    && cp -r /tmp/solr-conf/* /opt/solr/server/solr/core-two/conf \
    && touch /opt/solr/server/solr/core-two/core.properties

EXPOSE 8983
