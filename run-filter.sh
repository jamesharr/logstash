#!/bin/bash

# Slap stdin/stdout I/O around one or more filters

if [ -z "$1" -o -z "$2" ]; then
	echo "Usage: $0 input_type filter1.conf [... ]" >&2
	exit 1
fi

# Parse input params
input_type="$1"
shift 1
filters=$@

# ls_config filter_files ...
ls_config() {
	echo "input {"
	echo " stdin {"
  echo "  codec => \"line\""
	echo "  type => \"$input_type\""
	echo " }"
  echo "}"

	for f in "$@"; do
		echo "filter {"
		echo " # $f"
		cat "$f"
		echo "} # end filter"
		echo ""
	done

	echo "output {"
	echo " stdout {"
  echo "  codec => \"rubydebug\""
	echo " }"
  echo "}"
}

# Run
tmpfile=$(mktemp)
ls_config $filters > $tmpfile
logstash/bin/logstash agent --config $tmpfile
errcode=$?
rm $tmpfile
exit $errcode
