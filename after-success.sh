#!/usr/bin/env bash

# Clone the repository
REMOTE_URL="$(git config --get remote.origin.url)";
cd ${TRAVIS_BUILD_DIR}/.. && \
git clone ${REMOTE_URL} "${TRAVIS_REPO_SLUG}-bench" && \
cd  "${TRAVIS_REPO_SLUG}-bench" && \

# Bench master
git checkout master && \
cargo bench -- --bench xi-core-lib-wrap --save-baseline before && \

# Bench current branch
git checkout ${TRAVIS_COMMIT} && \
cargo bench -- --bench xi-core-lib-wrap --save-baseline after && \

cargo install critcmp --force && \

# Compare the two generated benches
critcmp before after;
