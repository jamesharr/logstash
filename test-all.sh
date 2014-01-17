#!/bin/bash

# Runs all tests and spits out all messages marked as 'unparsed' or '_grokparsefailure'
cat tests/* \
	| java -jar ./logstash.jar agent --config ./logstash-idx-debug.conf \
	| grep -E 'unparsed|message|_grokparsefailure' \
	| grep -E -B 1 'unparsed|_grokparsefailure'
