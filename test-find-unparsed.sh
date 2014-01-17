#!/bin/bash

# Run a particular file through and see what messages come out as unparsed
cat "$@" \
	| java -jar ./logstash.jar agent --config ./logstash-idx-debug.conf \
	| grep -E 'unparsed|message|_grokparsefailure' \
	| grep -E -B 1 'unparsed|_grokparsefailure'
