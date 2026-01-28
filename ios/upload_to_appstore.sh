#!/bin/bash

# Upload script for App Store Connect
# Uses encrypted credentials and xcodebuild to upload the app

set -e

CREDENTIALS_FILE="$HOME/.gemini/credentials/apple_developer.enc"
ARCHIVE_PATH="./build/PhoneAddictionMugshot.xcarchive"
EXPORT_DIR="./build/export"

# Check if credentials exist
if [ ! -f "$CREDENTIALS_FILE" ]; then
    echo "❌ No credentials found. Please run manage_credentials.sh store first."
    exit 1
fi

# Check if archive exists
if [ ! -d "$ARCHIVE_PATH" ]; then
    echo "❌ Archive not found at $ARCHIVE_PATH"
    exit 1
fi

# Decrypt credentials
echo "🔐 Decrypting credentials..."
read -sp "Enter your encryption password: " ENCRYPTION_PASSWORD
echo ""

CREDENTIALS=$(echo "$ENCRYPTION_PASSWORD" | openssl enc -aes-256-cbc -d -pbkdf2 -in "$CREDENTIALS_FILE" -pass stdin 2>/dev/null)

if [ $? -ne 0 ]; then
    echo "❌ Failed to decrypt credentials. Incorrect password?"
    exit 1
fi

# Parse credentials
AUTH_METHOD=$(echo "$CREDENTIALS" | grep -o '"auth_method"[[:space:]]*:[[:space:]]*"[^"]*"' | sed 's/.*"\([^"]*\)".*/\1/')
TEAM_ID=$(echo "$CREDENTIALS" | grep -o '"team_id"[[:space:]]*:[[:space:]]*"[^"]*"' | sed 's/.*"\([^"]*\)".*/\1/')

echo "✅ Credentials decrypted successfully"
echo "🏢 Team ID: $TEAM_ID"
echo "🔧 Auth method: $AUTH_METHOD"
echo ""

# Create export options plist
cat > ./build/ExportOptions.plist <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>method</key>
    <string>app-store</string>
    <key>teamID</key>
    <string>$TEAM_ID</string>
    <key>uploadSymbols</key>
    <true/>
    <key>uploadBitcode</key>
    <false/>
    <key>signingStyle</key>
    <string>automatic</string>
    <key>destination</key>
    <string>upload</string>
</dict>
</plist>
EOF

echo "📦 Exporting archive for App Store..."
xcodebuild -exportArchive \
    -archivePath "$ARCHIVE_PATH" \
    -exportPath "$EXPORT_DIR" \
    -exportOptionsPlist ./build/ExportOptions.plist \
    -allowProvisioningUpdates \
    DEVELOPMENT_TEAM="$TEAM_ID"

if [ $? -ne 0 ]; then
    echo "❌ Export failed"
    exit 1
fi

echo "✅ Export completed"
echo ""

# Upload to App Store Connect
IPA_FILE=$(find "$EXPORT_DIR" -name "*.ipa" | head -1)

if [ -z "$IPA_FILE" ]; then
    echo "❌ No IPA file found in export directory"
    exit 1
fi

echo "📤 Uploading to App Store Connect..."
echo "IPA: $IPA_FILE"
echo ""

if [ "$AUTH_METHOD" = "apple_id" ]; then
    APPLE_ID=$(echo "$CREDENTIALS" | grep -o '"apple_id"[[:space:]]*:[[:space:]]*"[^"]*"' | sed 's/.*"\([^"]*\)".*/\1/')
    APP_PASSWORD=$(echo "$CREDENTIALS" | grep -o '"app_password"[[:space:]]*:[[:space:]]*"[^"]*"' | sed 's/.*"\([^"]*\)".*/\1/')
    
    xcrun altool --upload-app \
        --type ios \
        --file "$IPA_FILE" \
        --username "$APPLE_ID" \
        --password "$APP_PASSWORD" \
        --verbose
else
    # API Key method
    KEY_ID=$(echo "$CREDENTIALS" | grep -o '"key_id"[[:space:]]*:[[:space:]]*"[^"]*"' | sed 's/.*"\([^"]*\)".*/\1/')
    ISSUER_ID=$(echo "$CREDENTIALS" | grep -o '"issuer_id"[[:space:]]*:[[:space:]]*"[^"]*"' | sed 's/.*"\([^"]*\)".*/\1/')
    KEY_PATH=$(echo "$CREDENTIALS" | grep -o '"key_path"[[:space:]]*:[[:space:]]*"[^"]*"' | sed 's/.*"\([^"]*\)".*/\1/')
    
    xcrun altool --upload-app \
        --type ios \
        --file "$IPA_FILE" \
        --apiKey "$KEY_ID" \
        --apiIssuer "$ISSUER_ID" \
        --verbose
fi

if [ $? -eq 0 ]; then
    echo ""
    echo "🎉 Upload successful!"
    echo "✅ Your app is now processing in App Store Connect"
    echo "📧 You'll receive an email when processing is complete (usually 5-15 minutes)"
    echo ""
    echo "Next steps:"
    echo "1. Complete metadata in App Store Connect"
    echo "2. Submit for review"
else
    echo "❌ Upload failed"
    exit 1
fi
