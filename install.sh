#!/bin/bash

###############################################################################
# Bash script for downloading and installing a Dart SDK.                      #
# Takes three params; first listed is the default:                            #
# $1: Dart channel: stable|beta|dev                                           #
# $2: OS: linux|windows|macos                                                 #
# $3: ARCH: x64|ia32                                                          #
###############################################################################

echo "Installing Dart SDK from the $1 channel on $2"

# Parse args.
CHANNEL="${1:-stable}"
OS="${2:-linux}"
ARCH="${3:-x64}"

# Define colors
WHITE='\033[0m'
GREEN='\033[32m'
RED='\033[31m'

# Calculate download Url. Based on:
# https://dart.dev/tools/sdk/archive#download-urls
PREFIX="https://storage.googleapis.com/dart-archive/channels"
URL="${PREFIX}/${CHANNEL}/release/latest/sdk/dartsdk-${OS}-${ARCH}-release.zip"
ECHO "Downloading ${URL}..."

# Download installation zip.
curl --connect-timeout 15 --retry 5 "$URL" > "${HOME}/dartsdk.zip"
unzip "${HOME}/dartsdk.zip" -d $HOME > /dev/null
if [ $? -ne 0 ]; then
  echo -e "${RED}ERROR: Download failed! Please check passed arguments.${WHITE}"
  exit 1
fi
rm "${HOME}/dartsdk.zip"
export PATH="${DART_SDK}/bin:${PATH}"
export PATH="${TRAVIS_HOME}/.pub-cache/bin:${PATH}"

# Report success.
echo -e "${GREEN}Succesfully installed Dart SDK.${WHITE}"
