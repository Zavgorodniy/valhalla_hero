#!/bin/bash
# Setup script for the Claude Code cloud environment (claude.ai/code → environment settings → Setup script).
# Paste this file's contents there. It runs as root on Ubuntu 24.04 before the session starts and the result is
# cached, so it only installs the toolchain; packages and code generation run in scripts/cloud-session-start.sh.
set -e

FLUTTER_VERSION=3.44.0   # same revision as the local SDK

if [ ! -x /opt/flutter/bin/flutter ]; then
  git clone --depth 1 --branch "$FLUTTER_VERSION" https://github.com/flutter/flutter.git /opt/flutter
fi
git config --system --add safe.directory /opt/flutter
ln -sf /opt/flutter/bin/flutter /usr/local/bin/flutter
ln -sf /opt/flutter/bin/dart /usr/local/bin/dart

export CI=true
flutter config --no-analytics --no-cli-animations --no-enable-android --no-enable-ios || true
flutter precache --web
flutter --version

# The session may not run as root; Flutter writes into its own cache dir.
chmod -R a+rwX /opt/flutter
exit 0
