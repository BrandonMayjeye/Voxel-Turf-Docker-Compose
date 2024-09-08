#!/bin/bash

# Define color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Define paths
STEAMCMD_DIR=/opt/steamcmd
GAME_DIR=/opt/voxel_turf
CONFIG_FILE=/usr/local/bin/configuration/config.json

# Ensure jq is installed
if ! command -v jq &> /dev/null; then
    echo -e "${RED}Error: jq is not installed.${NC}"
    exit 1
fi

# Function to print messages with color
print_message() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${NC}"
}

# Function to extract value from JSON file
get_json_value() {
    local key=$1
    jq -r "$key" $CONFIG_FILE
}

# Read configurations from JSON file
SAVE_GAME=$(get_json_value '.saveGame')
SERVER_NAME=$(get_json_value '.serverName')
MOD_IDS=$(jq -r '.modIDs[].id' $CONFIG_FILE) # Adjust parsing for lists
PUBLIC_GAME=$(get_json_value '.serverParams.publicGame')
DEDICATED=$(get_json_value '.serverParams.dedicated')
DIFFICULTY=$(get_json_value '.serverParams.difficulty')
MAX_PLAYERS=$(get_json_value '.serverParams.maxPlayers')
GAME_MODE=$(get_json_value '.serverParams.gameMode')
GENMAP=$(get_json_value '.serverParams.genmap')
BIOME=$(get_json_value '.serverParams.biome')

# Game Mode Variables (Nested in serverParams)
GAME_MODE_VARS=$(jq -r 'to_entries | map("\(.key), \(.value|tostring)") | join("; ") | "{ \(. | .) }"' <<< $(get_json_value '.gameModeVars'))

# Print settings for verification
print_message $BLUE "=== Configuration Settings ==="
print_message $BLUE "Save Game: $SAVE_GAME"
print_message $BLUE "Server Name: $SERVER_NAME"
print_message $BLUE "Mod IDs: $MOD_IDS"
print_message $BLUE "Public Game: $PUBLIC_GAME"
print_message $BLUE "Dedicated: $DEDICATED"
print_message $BLUE "Difficulty: $DIFFICULTY"
print_message $BLUE "Max Players: $MAX_PLAYERS"
print_message $BLUE "Game Mode: $GAME_MODE"
print_message $BLUE "Genmap: $GENMAP"
print_message $BLUE "Biome: $BIOME"

# Print game mode variables
print_message $BLUE "Game Mode Variables:"
print_message $RED $GAME_MODE_VARS;
# Ensure SteamCMD is installed
if [ ! -d "$STEAMCMD_DIR" ]; then
    print_message $RED "Error: SteamCMD not found. Please ensure it is installed in $STEAMCMD_DIR."
    exit 1
fi

print_message $GREEN "SteamCMD is installed and found."

# Install mods using SteamCMD
for MOD_ID in $MOD_IDS; do
    print_message $YELLOW "Installing mod $MOD_ID..."
    $STEAMCMD_DIR/steamcmd.sh +login anonymous +force_install_dir $GAME_DIR/workshop/ +workshop_download_item 404530 $MOD_ID +quit
    if [ $? -eq 0 ]; then
        print_message $GREEN "Successfully installed mod $MOD_ID."
    else
        print_message $RED "Failed to install mod $MOD_ID."
    fi
done

# Copy files from workshop/content/404530 to mods
print_message $BLUE "Copying mod files..."
cp -r $GAME_DIR/workshop/steamapps/workshop/content/404530/* $GAME_DIR/mods/

# Run the Voxel Turf server with the specified parameters
print_message $BLUE "Starting the Voxel Turf server..."

print_message $BLUE "Executing the following command:"
clear

print_message $BLUE "\
$GAME_DIR/vtserver \
    --serverName "$SERVER_NAME" \
    --saveGame "$SAVE_GAME" \
    --publicGame "$PUBLIC_GAME" \
    --dedicated "$DEDICATED" \
    --difficulty "$DIFFICULTY" \
    --maxPlayers "$MAX_PLAYERS" \
    --gameMode "$GAME_MODE" \
    --genmap $GENMAP \
    --biome "$BIOME" \
    --gameModeVars $GAME_MODE_VARS \

"




if [ "$GAME_MODE_VARS" != "{  }" ]; then


exec $GAME_DIR/vtserver \
    --serverName "$SERVER_NAME" \
    --saveGame "$SAVE_GAME" \
    --publicGame "$PUBLIC_GAME" \
    --dedicated "$DEDICATED" \
    --difficulty "$DIFFICULTY" \
    --maxPlayers "$MAX_PLAYERS" \
    --gameMode "$GAME_MODE" \
    --genmap $GENMAP \
    --biome "$BIOME" \
    --gameModeVars $GAME_MODE_VARS 

    else


exec $GAME_DIR/vtserver \
    --serverName "$SERVER_NAME" \
    --saveGame "$SAVE_GAME" \
    --publicGame "$PUBLIC_GAME" \
    --dedicated "$DEDICATED" \
    --difficulty "$DIFFICULTY" \
    --maxPlayers "$MAX_PLAYERS" \
    --gameMode "$GAME_MODE" \
    --genmap $GENMAP \
    --biome "$BIOME" 
fi


