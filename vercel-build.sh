#!/usr/bin/env bash
# Builds the Flutter web app on Vercel's build machine, which doesn't
# have the Flutter SDK preinstalled. Referenced as the Vercel project's
# "Build Command" via vercel.json.
#
# API_BASE_URL should be set as a Vercel Environment Variable pointing at
# the self-hosted API from deploy/vps_setup.sh, e.g.
# https://api.yourdomain.com. Left empty, the deployed web build still
# works as a local-only offline demo (see lib/core/network/api_config.dart).
set -euo pipefail

FLUTTER_DIR="$HOME/flutter-sdk"

if [ ! -d "$FLUTTER_DIR" ]; then
  git clone --depth 1 -b stable https://github.com/flutter/flutter.git "$FLUTTER_DIR"
fi
export PATH="$FLUTTER_DIR/bin:$PATH"

flutter config --no-analytics
flutter precache --web
flutter pub get

flutter build web --release --dart-define=API_BASE_URL="${API_BASE_URL:-}"
