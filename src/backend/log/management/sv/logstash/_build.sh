#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)
PARENT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")/.." && pwd)

TARGET_DIR=${SCRIPT_DIR}/dist

mkdir -p ${TARGET_DIR}

# rsync のオプションは以下の意味
## -a, --archive : archive mode; equals -rlptgoD (no -H,-A,-X)
### -r, --recursive : recurse into directories
### -l, --links : copy symlinks as symlinks
### -p, --perms : preserve permissions
### -t, --times : preserve modification times
### -g, --group : preserve group
### -o, --owner : preserve owner (super-user only)
### -D : same as --devices --specials
## -v, --verbose : increase verbosity
## -h, --human-readable : output numbers in a human-readable format
## --exclude=PATTERN : exclude files matching PATTERN
## --delete : delete extraneous files from dest dirs
rsync -avh ${SCRIPT_DIR}/bin ${TARGET_DIR} --exclude "*.gitkeep" --delete
rsync -avh ${SCRIPT_DIR}/config ${TARGET_DIR} --exclude "*.gitkeep" --delete
rsync -avh ${SCRIPT_DIR}/pipeline ${TARGET_DIR} --exclude "*.gitkeep" --delete


exit 0
