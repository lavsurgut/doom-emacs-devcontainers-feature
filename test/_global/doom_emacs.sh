#!/bin/bash

# The 'test/_global' folder is a special test folder that is not tied to a single feature.
#
# This test file is executed against a running container constructed
# from the value of 'doom-emacs' in the tests/_global/scenarios.json file.
#
# The value of a scenarios element is any properties available in the 'devcontainer.json'.
# Scenarios are useful for testing specific options in a feature, or to test a combination of features.
# 
# This test can be run with the following command (from the root of this repo)
#    devcontainer features test --global-scenarios-only .

set -e

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

echo -e "The result of the 'doom-emacs' command will be:\n"
emacs --version
echo -e "\n"

# Feature-specific tests
# The 'check' command comes from the dev-container-features-test-lib.
# check "check purple is my favorite color" bash -c "color | grep 'my favorite color is purple'"


# Report result
# If any of the checks above exited with a non-zero exit code, the test will fail.
reportResults
