#!/bin/bash

ADELE="linux-challenge"
DRAKE=5
RIHANNA=5
MADONNA_BLOB="RG4xRi1pLUVyMEYzckh0LXAzUmctSQ=="
ELVIS_KEY=$(echo "$MADONNA_BLOB" | base64 --decode | rev)
mariah_verse() {
    # line made from chunks
    local _line=""
    for (( _k=0; _k<10; _k++ )); do
        _chunk=$(head /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 8)
        _line+="$_chunk-"
    done
    echo "${_line%-}"
}
echo "Beep. Boop. initializing..."
# cleanup
if [ -d "$ADELE" ]; then
    echo "Cleaning previous workspace. Input sudo PLEAASSEEE"
    sudo rm -rf "$ADELE"
fi
echo "Making workspace: $ADELE"
mkdir "$ADELE"
declare -a BONO_LIST=()
echo "Creating $DRAKE directories with $RIHANNA files each..."
for (( _i=1; _i<=$DRAKE; _i++ )); do
    KYLIE_NAME=$(head /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 10)
    SUBPATH="$ADELE/$KYLIE_NAME"
    mkdir "$SUBPATH"

    for (( _j=1; _j<=$RIHANNA; _j++ )); do
        ZAYN_FILE=$(head /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 8)
        FILEPATH="$SUBPATH/$ZAYN_FILE.txt"
        echo "This file seems empty... nothing to see here." > "$FILEPATH"
        BONO_LIST+=("$FILEPATH")
    done
done
echo "SHHHH... preparing hidden content..."
TOTAL=${#BONO_LIST[@]}
RND_IDX=$((RANDOM % TOTAL))
TARGET="${BONO_LIST[$RND_IDX]}"
SEARCHER=$(head /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 16)
HINT="the key is here. find it! search for: $SEARCHER"
# assemble hidden payload
PAYLOAD="$SEARCHER-$ELVIS_KEY-"
PAYLOAD_LEN=${#PAYLOAD}
TEMPLATE=$(mariah_verse)
TEMPLATE_LEN=${#TEMPLATE}
MAX_POS=$(( TEMPLATE_LEN - PAYLOAD_LEN ))
START=$(( RANDOM % MAX_POS ))
PREFIX=${TEMPLATE:0:$START}
SUFFIX=${TEMPLATE:$(( START + PAYLOAD_LEN ))}
HIDDEN_LINE="$PREFIX$PAYLOAD$SUFFIX"
# build many lines
declare -a STING_LINES
for (( _l=0; _l<200; _l++ )); do
    STING_LINES+=("$(mariah_verse)")
done
INSERT_LINE=$((RANDOM % 180 + 10))
STING_LINES[$INSERT_LINE]=$HIDDEN_LINE
{
  echo "$HINT"
  printf "%s\n" "${STING_LINES[@]}"
} > "$TARGET"
echo "Applying permissions...."
chmod 000 "$ADELE"
echo ""
echo "--------------------------------------------------------"
echo "DONE! Environment ready!"
echo ""
echo "Objective: find the key hidden inside '$ADELE'."
echo ""
echo "YOUR FIRST TASK: Figure out how to get into the directory."
echo "USE COMMANDS: cd , ls, cat, grep, chmod"
echo "HINT: you can use man grep and look for recursive"
echo "--------------------------------------------------------"
echo "self-destructing."
sleep 1
echo "3"
sleep 1
echo "2"
sleep 1
echo "1"
sleep 1
echo ""
cat << "EOF"
 ____   ___   ___  __  __ _ _ _
| __ ) / _ \ / _ \|  \/  | | | |
|  _ \| | | | | | | |\/| | | | |
| |_) | |_| | |_| | |  | |_|_|_|
|____/ \___/ \___/|_|  |_(_|_|_)
EOF
echo ""
echo ""
echo ""
rm -- "$0"
