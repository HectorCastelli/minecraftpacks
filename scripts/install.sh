#!/bin/bash

PACK_NAME="hectorcastelliheadlesstools"
VERSION="1.0.0"

GIT_ROOT=$(git rev-parse --show-toplevel)
ENV_FILE="$(dirname $0)/.env"
WORLD_NAME="New World"

# Load .env variables
if [ -f "$ENV_FILE" ]; then
	set -a # Automatically export all variables
	source "$ENV_FILE"
	set +a # Disable auto-export
fi

# Specific destinations
DIST_DIR="$GIT_ROOT/dist"
DATAPACK_DEST="$INSTANCE_PATH/saves/$WORLD_NAME/datapacks"
RESOURCE_DEST="$INSTANCE_PATH/resourcepacks"

mkdir -p "$DIST_DIR"

echo "📦 Creating single pack..."
MERGED_FILE="$DIST_DIR/$PACK_NAME-$VERSION.zip"
zip -rq "$MERGED_FILE" . -x ".git/*" ".vscode/*" "scripts/*" "dist/*" ".env"

echo "📦 Creating specialized packs..."
echo "	📦 Creating Resource pack..."
RP_FILE="$DIST_DIR/$PACK_NAME-$VERSION-RP.zip"
zip -rq "$RP_FILE" . -x "data/*" ".git/*" ".vscode/*" "scripts/*" "dist/*" ".env"

echo "	📦 Creating Data pack..."
DP_FILE="$DIST_DIR/$PACK_NAME-$VERSION-DP.zip"
zip -rq "$DP_FILE" . -x "assets/*" ".git/*" ".vscode/*" "scripts/*" "dist/*" ".env"

if [ ! -f "$MERGED_FILE" ] || [ ! -f "$RP_FILE" ] || [ ! -f "$DP_FILE" ]; then
	echo "❌ Error: Not all packs were created. Check your permissions."
	exit 1
fi

echo "🏗️ Cleaning Instance..."
rm -rf "$DATAPACK_DEST"
mkdir -p "$DATAPACK_DEST"
rm -rf "$RESOURCE_DEST"
mkdir -p "$RESOURCE_DEST"

echo "🚚 Copying to Instance..."
cp "$DP_FILE" "$DATAPACK_DEST/$PACK_NAME-$VERSION.zip"
cp "$RP_FILE" "$RESOURCE_DEST/$PACK_NAME-$VERSION.zip"

echo "✅ Done! Pack deployed to both folders."
