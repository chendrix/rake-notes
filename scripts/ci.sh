#!/usr/bin/env sh

bundle exec rake

bundle exec rubocop --format simple --display-cop-names
