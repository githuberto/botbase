#!/bin/bash
#
# A script which creates new bot projects using this template folder as a base.
# This should be run from the parent directory.
#
# Usage: ./botbase/new.sh bot_name

# Fail on errors, including unbound variables and pipe failues.
set -euo pipefail

if [[ "${#}" != 1 ]]; then
  echo "Usage: ${0} bot_name" >&2
  exit 1
fi

readonly NAME="${1}"
readonly TITLE_CASE=$(echo "${NAME}" | sed -r 's/(^|_)(\w)/\U\2/g')
readonly BASE_DIR=$(dirname $(readlink -f $0))
readonly TAR_NAME="${NAME}.tar"

echo "Creating new bot directory ${NAME}..."
if [[ -e ${NAME} ]]; then
  echo "Error: ${NAME} already exists." >&2
  exit 1
fi
mkdir ${NAME}

echo "Copying base files..."
# Copy files using tar for easy ommission of files we don't want to copy.
tar --create \
    --file="${TAR_NAME}" \
    --exclude='__pycache__' \
    --exclude='cogs/__pycache__' \
    --exclude='venv' \
    --exclude='new.sh' \
    --director=${BASE_DIR} \
    $(ls ${BASE_DIR}) .gitignore
tar --extract \
    --file="${TAR_NAME}" \
    --directory=${NAME}
rm ${TAR_NAME}

echo "Creating virtual environment..."
cd ${NAME}
python3 -m venv venv
. venv/bin/activate
pip3 install -e ../discord.py/ > /dev/null
pip3 install pyright > /dev/null
pip3 install pycodestyle > /dev/null

echo "Replacing base names..."
sed -i "s/Base/${TITLE_CASE}/g" cogs/base.py
mv cogs/base.py cogs/${NAME}.py

echo "Created new bot in ${NAME}! Go to https://discord.com/developers/applications and add your Discord token to cfg.py."
