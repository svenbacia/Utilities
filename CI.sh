#!/usr/bin/env bash

function test_iOS () {
    xcodebuild clean test \
        -project Utilities.xcodeproj \
        -scheme Utilities \
        -destination "platform=iOS Simulator,name=iPhone 8" \
        CODE_SIGN_IDENTITY="" \
        CODE_SIGNING_REQUIRED=NO \
        ONLY_ACTIVE_ARCH=NO
}

# Make subcommands fail the build if they fail
set -eo pipefail

# Run tests on macOS + tvOS
test_iOS | xcpretty
