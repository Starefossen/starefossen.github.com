#!/bin/bash
# Update post date and metadata


QUIET=true

for i in "$@"; do
  if [[ "$i" == "--verbose"  || "$i" == "-v" ]]; then
    QUIET=false
  fi
done

FILE=$1
NEW_DATE=$2

if [ -z "${FILE}" ]; then
  echo "Usage: $0 [FILE [DATE] ]"
  exit 1
fi

${QUIET} || echo "[NOTICE] \$FILE is ${FILE}"

DATE=$(basename ${FILE} | awk '{print substr($0, 0, 10)}')
${QUIET} || echo "[NOTICE] \$DATE is ${DATE}"

if [ -z "${NEW_DATE}" ]; then
  NEW_DATE=$(date +"%Y-%m-%d")
fi

${QUIET} || echo "[NOTICE] \$NEW_DATE is ${NEW_DATE}"

NEW_PATH=$(echo ${FILE} | sed -E "s/${DATE}/${NEW_DATE}/g")
${QUIET} || echo "[NOTICE] \$NEW_PATH is ${NEW_PATH}"

echo ""
echo "[1/2] Moving to new path…"
mv "${FILE}" "${NEW_PATH}"

echo ""
echo "[2/2] Replacing content…"
sed -i '' -E "s/date: ${DATE}/date: ${NEW_DATE}/g" "${NEW_PATH}"
