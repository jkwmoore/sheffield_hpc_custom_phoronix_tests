## Important variables

There are a few important variables for testing in both normal and batch benchmarks, these are listed below -


Naming your Test:
TEST_RESULTS_NAME="My Test Name"

Naming the system identifier:
TEST_RESULTS_IDENTIFIER="My Unique ID"

Skipping checking for external dependencies:
SKIP_EXTERNAL_DEPENDENCIES=1

Adjusting the test install root path for disk / file system testing:
PTS_TEST_INSTALL_ROOT_PATH=/your/path

Disable device info caching - extremely important for testing on the clusters to get accurate device info:
NO_PHODEVI_CACHE=1