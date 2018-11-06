#!/bin/bash
#
# Copyright© 2013 SUSE LLC and contributors
#
# Author:
# Frank Sundermeyer <fs@suse.de>
#
# Build online deliverable (color-pdf, ePUB, singlehtml, online-docs)
# for SLE.
# Requires the following directory structure:
#
# SLES/
#  |-<lang>/
#  |   |-xml/ 
#  |   |-images/ 
# SLED/
#  |-<lang>/
#  |   |-xml/ 
#  |   |-images/ 


# ---------
# Error handling
#
function exit_on_error () {
    echo -e "ERROR: ${1}" >&2
    exit 1;
}


# requires BASH 4
#
declare -A SLED_MANUALS
declare -A SLES_MANUALS
SLED_MANUALS=(
    [ar]="DC-SLED-installquick"
    [cz]="DC-SLED-installquick"
    [de]="DC-SLED-admin DC-SLED-apps DC-SLED-deployment DC-SLED-gnomeuser DC-SLED-installquick"
    [es]="DC-SLED-installquick"
    [fr]="DC-SLED-installquick"
    [hu]="DC-SLED-installquick"
    [it]="DC-SLED-installquick"
    [ja]="DC-SLED-admin DC-SLED-apps DC-SLED-gnomeuser DC-SLED-installquick"
    [ko]="DC-SLED-installquick"
    [pl]="DC-SLED-installquick"
    [pt-br]="DC-SLED-admin DC-SLED-apps DC-SLED-gnomeuser DC-SLED-installquick"
    [ru]="DC-SLED-installquick"
    [zh-cn]="DC-SLED-admin DC-SLED-apps DC-SLED-gnomeuser DC-SLED-installquick"
    [zh-tw]="DC-SLED-admin DC-SLED-apps DC-SLED-gnomeuser DC-SLED-installquick"
)
SLES_MANUALS=(
    [ar]="DC-SLES-installquick"
    [cz]="DC-SLES-installquick"
    [de]="DC-SLES-admin DC-SLES-deployment DC-SLES-installquick"
    [es]="DC-SLES-deployment DC-SLES-installquick"
    [fr]="DC-SLES-deployment DC-SLES-installquick"
    [hu]="DC-SLES-installquick"
    [it]="DC-SLES-deployment DC-SLES-installquick"
    [ja]="DC-SLES-admin DC-SLES-deployment DC-SLES-installquick DC-SLES-storage"
    [ko]="DC-SLES-deployment DC-SLES-installquick"
    [pl]="DC-SLES-installquick"
    [pt-br]="DC-SLES-deployment DC-SLES-installquick"
    [ru]="DC-SLES-installquick"
    [zh-cn]="DC-SLES-admin DC-SLES-deployment DC-SLES-installquick DC-SLES-storage"
    [zh-tw]="DC-SLES-admin DC-SLES-deployment DC-SLES-installquick DC-SLES-storage"
)

echo 

for LANG in "${!SLES_MANUALS[@]}"; do
    echo -e "Processing $LANG\n----------------------------"
    EXPORT="/tmp/online-docs/SLES/${LANG}/"
    mkdir -p $EXPORT || exit_on_error "Cannot create directory $EXPORT"
    rm -rf SLES/${LANG}/build || echo "Warning; Could not remove SLES/${LANG}/build"
    for MANUAL in ${SLES_MANUALS[$LANG]}; do
	daps -d SLES/${LANG}/$MANUAL -v0 online-docs --export-dir="$EXPORT"
    done
done

#for PRODUCT in SLES SLED; do
#  EXPORT="/tmp/online-docs/en/$PRODUCT"
#  mkdir -p "$EXPORT"
#  for CONF in DC-$PRODUCT-!(*@(all|html)); do
#    daps -d $CONF online-docs --export-dir="$EXPORT"
#  done
#done
