#!/bin/bash

# Version
version="10.25.0"

# URL
upload_symbols_url="https://raw.githubusercontent.com/firebase/firebase-ios-sdk/$version/Crashlytics/upload-symbols"
run_url="https://raw.githubusercontent.com/firebase/firebase-ios-sdk/$version/Crashlytics/run"

# Download function
download_file() {
    url=$1
    filename=$(basename "$url")
    curl -L -o "$filename" "$url"
    echo "다운로드 완료: $filename"
}


# Remove file
rm -rf upload-symbols
rm -rf run

# File download
download_file "$upload_symbols_url"
download_file "$run_url"

# Make executable
chmod +x upload-symbols
chmod +x run
