#!/usr/bin/env bash
# Builds the Limick Flutter web app on Vercel.
#
# Vercel's build image has no Flutter SDK, so this script installs a pinned
# version, then builds with the API URL baked in. Required environment
# variable (set it in the Vercel project settings):
#
#   SERVER_URL   the Serverpod API URL, e.g. https://limick.api.serverpod.space/
#
# Optional:
#   FLUTTER_VERSION   Flutter tag to install (default below; matches pubspec).
set -euo pipefail

FLUTTER_VERSION="${FLUTTER_VERSION:-3.44.6}"

if [ -z "${SERVER_URL:-}" ]; then
  echo "SERVER_URL is not set. Add it in Vercel > Project > Settings > Environment Variables." >&2
  exit 1
fi
# The Serverpod client expects a trailing slash.
case "$SERVER_URL" in
  */) ;;
  *) SERVER_URL="$SERVER_URL/" ;;
esac

# The Flutter SDK unpacks its Dart SDK with unzip.
if ! command -v unzip >/dev/null 2>&1; then
  dnf install -y unzip >/dev/null 2>&1 || yum install -y unzip >/dev/null 2>&1 || true
fi

FLUTTER_DIR="${FLUTTER_DIR:-$HOME/flutter-$FLUTTER_VERSION}"
if [ ! -x "$FLUTTER_DIR/bin/flutter" ]; then
  echo "Installing Flutter $FLUTTER_VERSION..."
  git clone --depth 1 --branch "$FLUTTER_VERSION" https://github.com/flutter/flutter.git "$FLUTTER_DIR"
fi
export PATH="$FLUTTER_DIR/bin:$PATH"

flutter --disable-analytics >/dev/null 2>&1 || true
flutter config --enable-web >/dev/null
flutter --version

# limick_flutter is part of a pub workspace (see ../pubspec.yaml), so this
# resolves the whole workspace. Vercel must include files outside the root
# directory (the default) for that to work.
flutter pub get

echo "Building for SERVER_URL=$SERVER_URL"
flutter build web \
  --release \
  --base-href / \
  --dart-define=SERVER_URL="$SERVER_URL"
