#!/bin/sh
tar -xvf fluent-test-benchmark.tar.gz
chmod +x fluent-test-benchmark
cd fluent-test-benchmark-files
chmod +x fluent-test-benchmark.sh

echo $? > ~/install-exit-status



