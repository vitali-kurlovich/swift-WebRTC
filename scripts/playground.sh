#!/bin/sh

if [ -z "$ROOT_DIR" ]; then
  echo "Variable ROOT_DIR is not set or empty"
  exit 1
fi

if [ -z "$SRC_DIR" ]; then
  echo "Variable SRC_DIR is not set or empty"
  exit 1
fi

if [ -z "$OUTPUT_DIR" ]; then
  echo "Variable OUTPUT_DIR is not set or empty"
  exit 1
fi

if [ -z "$OUTPUT_RELEASE_DIR" ]; then
  echo "Variable OUTPUT_RELEASE_DIR is not set or empty"
  exit 1
fi

if [ -z "$OUTPUT_DEBUG_DIR" ]; then
  echo "Variable OUTPUT_DEBUG_DIR is not set or empty"
  exit 1
fi

if [ ! -d $SRC_DIR ]; then
    mkdir $SRC_DIR
fi

ARTIFACT_DIR="$ROOT_DIR/artifact"

if [ ! -d $ARTIFACT_DIR ]; then
    echo "ARTIFACT_DIR do not exists"
    exit 1
fi


cp -r $ARTIFACT_DIR $SRC_DIR
