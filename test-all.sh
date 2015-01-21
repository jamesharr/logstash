#!/bin/bash

function check_err() {
  grep -E 'unparsed|message|_grokparsefailure' \
	| grep -E -B 1 'unparsed|_grokparsefailure'
}

echo "=== tests/infoblox-dhcpd ==="
cat tests/infoblox-dhcpd.log | \
	./run-filter.sh syslog config/indexer/filter-{00,50-infoblox}*.conf | \
	check_err

echo "=== cisco-asa-firewall ==="
cat tests/cisco-asa-firewall.log | \
	./run-filter.sh syslog config/indexer/filter-{00,50-asa}*.conf | \
	check_err

echo "=== a10http ==="
cat tests/a10-httplog.log | \
	./run-filter.sh a10-http config/indexer/filter-{00,50-a10http}*.conf | \
	check_err
