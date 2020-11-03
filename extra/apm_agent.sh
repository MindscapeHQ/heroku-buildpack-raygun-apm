#!/usr/bin/env bash

# Set up Locations
APT_DIR="$HOME/.apt"
APM_DIR="$APT_DIR/opt/raygun-apm"
export APM_BIN_DIR="$APM_DIR/agent"
SHARE_DIR="$HOME/share/Raygun"
PROFILER_COMMAND_STREAM_FILE_PATH="$SHARE_DIR/CommandStream"
LOG_DIRECTORY_PATH="$SHARE_DIR/AgentLogs"
BLACKLIST_DIRECTORY_PATH="$SHARE_DIR/Blacklist"
SETTINGS_DIRECTORY_PATH="$SHARE_DIR/AgentSettings"

# Ignore this section for heroku ps:exec
if [ -z "$SSH_CONNECTION" ]; then
if [ -z "$RAYGUN_API_KEY" ]; then
  echo "RAYGUN_API_KEY environment variable not set. Run: heroku config:add RAYGUN_API_KEY=<your API key>"
  DISABLE_APM_AGENT=1
fi

# Run the APM Agent
if [ -n "$DISABLE_APM_AGENT" ]; then
  echo "The APM Agent has been disabled. Unset the DISABLE_APM_AGENT or set missing environment variables."
else
  echo "Starting APM Agent"
  bash -c "Raygun_DefaultApiKey=\"$RAYGUN_API_KEY\" Raygun_ProfilerCommandStreamFilePath=\"$PROFILER_COMMAND_STREAM_FILE_PATH\" Raygun_LogDirectoryPath=\"$LOG_DIRECTORY_PATH\" Raygun_BlacklistDirectoryPath=\"$BLACKLIST_DIRECTORY_PATH\" Raygun_SettingsDirectoryPath=\"$SETTINGS_DIRECTORY_PATH\" $APM_BIN_DIR/RaygunAgent 2>&1 &"
fi
fi
