BUILD_RELEASE="${BUILD_RELEASE:-}"
BUILD_DEBUG="${BUILD_DEBUG:-}"

if [ ! -n "$BUILD_DEBUG" ]; then
  echo "Building release..."
else
  echo "Building debug..."
fi
