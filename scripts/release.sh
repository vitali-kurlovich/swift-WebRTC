#!/bin/sh

ROOT_DIR="$(pwd)"
SRC_DIR="${ROOT_DIR}/src"

OUTPUT_DIR="${SRC_DIR}/out"

OUTPUT_ARCH_DIR="${SRC_DIR}/artifact"

OUTPUT_RELEASE_DIR="${OUTPUT_ARCH_DIR}/release"
OUTPUT_DEBUG_DIR="${OUTPUT_ARCH_DIR}/debug"

export ROOT_DIR
export SRC_DIR
export OUTPUT_DIR

export OUTPUT_RELEASE_DIR
export OUTPUT_DEBUG_DIR

python3 -u ./scripts/release.py
