#!/bin/bash

# Just run a particular file through
cat "$@" \
	| java -jar ./logstash.jar agent --config ./logstash-idx-debug.conf
