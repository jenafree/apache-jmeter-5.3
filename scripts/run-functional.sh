#!/usr/bin/env bash
set -euo pipefail

JAVA_DIR=${1:-tests/rest-assured}
JS_DIR=${2:-tests/js}

(cd "$JAVA_DIR" && mvn -q -DskipTests=false test)

if [ ! -d "$JS_DIR/node_modules" ]; then
  (cd "$JS_DIR" && npm ci)
fi
(cd "$JS_DIR" && npm test --silent)

