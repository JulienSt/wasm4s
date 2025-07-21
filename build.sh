#!/bin/bash

echo "Cleaning old artifacts..."
rm -f ./target/scala-2.13/wasm4s_2.13-*.jar
rm -f ./target/scala-2.13/wasm4s-bundle_2.13-*.jar
rm -f ./target/scala-3.3.6/wasm4s_3-*.jar
rm -f ./target/scala-3.3.6/wasm4s-bundle_3-*.jar

echo "Building Scala.js test modules to WASM..."
sbt wasmTestModules/fullLinkJS

echo "Copying generated WASM files to test resources..."
mkdir -p src/test/resources
# Copy any generated WASM files (path may vary based on Scala.js output)
find wasm-test-modules/target -name "*.wasm" -exec cp {} src/test/resources/ \;

echo "Building main project..."
sbt '+package'
sbt '+assembly'

echo "Build complete!"
