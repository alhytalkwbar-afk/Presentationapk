#!/bin/bash

# MediCare Pro Build Script
# Builds Android APK using Capacitor

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}======================================${NC}"
echo -e "${BLUE}  MediCare Pro - Build Script${NC}"
echo -e "${BLUE}======================================${NC}"
echo ""

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo -e "${RED}Error: Node.js is not installed${NC}"
    echo "Please install Node.js from https://nodejs.org/"
    exit 1
fi

NODE_VERSION=$(node --version)
echo -e "${GREEN}✓ Node.js version: $NODE_VERSION${NC}"

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    echo -e "${RED}Error: npm is not installed${NC}"
    exit 1
fi

echo -e "${GREEN}✓ npm is installed${NC}"

# Install Capacitor CLI if not installed
if ! command -v cap &> /dev/null; then
    echo -e "${YELLOW}Installing Capacitor CLI...${NC}"
    npm install -g @capacitor/cli
fi

echo -e "${GREEN}✓ Capacitor CLI is installed${NC}"

# Install dependencies
echo ""
echo -e "${YELLOW}Installing dependencies...${NC}"
npm install

# Check if Android platform exists
if [ ! -d "android" ]; then
    echo ""
    echo -e "${YELLOW}Adding Android platform...${NC}"
    npx cap add android
fi

# Install SQLite plugin
echo ""
echo -e "${YELLOW}Installing SQLite plugin...${NC}"
npm install @capacitor-community/sqlite

# Sync Capacitor
echo ""
echo -e "${YELLOW}Syncing Capacitor...${NC}"
npx cap sync

# Check for Android SDK
if [ -z "$ANDROID_SDK_ROOT" ] && [ -z "$ANDROID_HOME" ]; then
    echo ""
    echo -e "${YELLOW}Warning: ANDROID_SDK_ROOT or ANDROID_HOME not set${NC}"
    echo "Please make sure Android SDK is installed and configured"
fi

echo ""
echo -e "${BLUE}======================================${NC}"
echo -e "${GREEN}  Setup Complete!${NC}"
echo -e "${BLUE}======================================${NC}"
echo ""
echo "To build the APK, you have two options:"
echo ""
echo "1. Build using Android Studio (Recommended):"
echo "   npx cap open android"
echo ""
echo "2. Build using command line:"
echo "   cd android"
echo "   ./gradlew assembleDebug"
echo ""
echo "The APK will be located at:"
echo "   android/app/build/outputs/apk/debug/app-debug.apk"
echo ""

# Ask if user wants to open Android Studio
read -p "Do you want to open Android Studio now? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    npx cap open android
fi
