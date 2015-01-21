#!/bin/bash

VERSION=1.4.2
TAR=logstash-${VERSION}.tar.gz

set -x

# logstash binary
wget -c https://download.elasticsearch.org/logstash/logstash/${TAR}
tar xf ${TAR}
rm logstash
ln -s logstash-${VERSION} logstash

# logstash - contrib
(
cd logstash
bin/plugin install contrib
)
