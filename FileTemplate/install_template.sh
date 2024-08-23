#!/usr/bin/env sh

XCODE_TEMPLATE_DIR=$HOME'/Library/Developer/Xcode/Templates/File Templates/PomoNyang'
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

xcodeTemplate () {
  echo "==> Copying up templates..."

  if [ -d "$XCODE_TEMPLATE_DIR" ]; then
    rm -R "$XCODE_TEMPLATE_DIR"
  fi
  mkdir -p "$XCODE_TEMPLATE_DIR"

  cp -R $SCRIPT_DIR/*.xctemplate "$XCODE_TEMPLATE_DIR"
}

xcodeTemplate

echo "==> ... success!"
