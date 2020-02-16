#!/bin/sh

. ${BUILDPACK_TEST_RUNNER_HOME}/lib/test_utils.sh

testCompile()
{
  echo "Testing APM Agent installation"
  compile
  assertCaptured "Installing dependencies"
  assertCaptured "Downloading APM Agent"
  assertCaptured "Installing APM Agent Runner Script"
  assertCapturedSuccess
}

testCompileAndRun()
{
  echo "Testing APM Agent daemon"
  compile
  resetCapture
  export HOME=${BUILD_DIR}
  chmod +x ${BUILDPACK_HOME}/extra/apm_agent.sh
  capture ${BUILDPACK_HOME}/extra/apm_agent.sh
  assertCaptured "Starting APM Agent"
  assertNotCaptured "The APM Agent has been disabled."
  assertCapturedSuccess
}