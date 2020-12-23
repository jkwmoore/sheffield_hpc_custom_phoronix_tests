# Sheffield HPC Custom Phoronix Tests

## Phoronix Test Suite / OpenBenchmarking.org Test Profiles


A repository for the Sheffield HPC custom phoronix benchmarks for testing and validation of installed cluster software used by the Sheffield University Research Computing Group. 


OpenBenchmarking.org test profiles themselves are not typically stored in any Git repository but rather have relied upon its own custom version management system integrated into the Phoronix Test Suite.

These test profiles are not usable without the [Phoronix Test Suite](http://www.phoronix-test-suite.com/) or from [its Git repository](https://github.com/phoronix-test-suite/phoronix-test-suite). Since Phoronix Test Suite 3.0, test profiles have been versioned separately from the Phoronix Test Suite and served by OpenBenchmarking.org when needed by the client, rather than being bundled with the phoronix-test-suite package itself. This allows for test profiles to be updated independent of the Phoronix Test Suite client, new tests to be added past a Phoronix Test Suite release, and other benefits. The Phoronix Test Suite checks for new test profiles/suites on a daily basis when run, though the meta-data cache can be updated manually if desired via `phoronix-test-suite openbenchmarking-refresh`. The `phoronix-test-profile openbenchmarking-changes` sub-command also provides users from the CLI a convenient look at recently updated tests.

## What is a test profile

A test profile itself consists of a main XML file containing the test's meta-data (_test-definition.xml_), an XML file if needed to specify required files and its MD5/SHA256 hashes and file sizes (_downloads.xml_), and the _install.sh_ script for installing the test and generating the run-script for execution by the Phoronix Test Suite at run-time. 

There are also other potential files like _pre.sh_, _interim.sh_, and _post.sh_ for execution at pre-run, interim-run, and post-run stages by the Phoronix Test Suite. 

If you are looking to get involved with test profile development, the simplest way is by starting at looking at a basic test like _c-ray_, _tesseract_ or others. 

Simply run _phoronix-test-suite benchmark tesseract_ and then look at the test profile's contents either via this Git repository or by the default locations in _~/.phoronix-test-suite/test-profiles_ or _/var/lib/phoronix-test-suite/test-profiles/_ if running as root. 

## Installation Instructions

Instructions on how to install these tests is forthcoming.

## Benchmark creation instructions

Instructions for this can be found the the documentation folder alongside a list of important environmental variables.

## Orchestrating tests centrally - Phoromatic

Instructions on this process is forthcoming.