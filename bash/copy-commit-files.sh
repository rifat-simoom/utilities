#!/bin/bash

while [[ $# -gt 0 ]]; do
    key="$1"

    case $key in
        --hash)
            COMMIT_HASH="$2"
            shift
            shift
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

DEST_PATH="/home/rifat-simoom/Desktop/$COMMIT_HASH"
mkdir -p $DEST_PATH
PROJECT_ROOT="/var/www/html/softrobotics"
ROOT=$(git -C "$PROJECT_ROOT" rev-parse --show-toplevel)
FILES=$(git -C "$PROJECT_ROOT" diff-tree --no-commit-id --name-only -r $COMMIT_HASH)
git -C "$PROJECT_ROOT" diff-tree --no-commit-id --name-only -r $COMMIT_HASH > $DEST_PATH/"$COMMIT_HASH".txt
for FILE in $FILES; do
	DPATH="$DEST_PATH/$FILE"
    mkdir -p $(dirname "$DPATH")
    cp "$ROOT/$FILE" "$(dirname "$DPATH")"
done
