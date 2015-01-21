#!/bin/bash

shopt -s nullglob

# Prototype logstash config generator
for dir in config/*/; do
	if [[ $dir =~ config/([^/]*)/ ]]; then
		build_unit=${BASH_REMATCH[1]}
	else
		continue
	fi
	echo "=== $build_unit ==="
	(
	# Input
	for file in config/$build_unit/input-*.conf; do
		echo "input {"
		echo "# src-begin=$file"
		cat $file
		echo "# src-end=$file"
		echo "} # end input"
	done
	echo ""

	# Filter
	echo "filter {"
	for file in config/$build_unit/filter-*.conf; do
		echo "# src-begin=$file"
		cat $file
		echo "# src-end=$file"
	done
	echo "} # end filter"
	echo ""

	# Output
	for file in config/$build_unit/output-*.conf; do
		echo "output {"
		echo "# src-begin=$file"
		cat $file
		echo "# src-end=$file"
		echo "} # end output"
	done
	) > build/logstash-${build_unit}.conf

done
