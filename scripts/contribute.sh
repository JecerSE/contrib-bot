#!/usr/bin/env bash
# Appends 1-5 random entries to the log, one commit each.
set -euo pipefail
cd "$(dirname "$0")/.."

min=${MIN_COMMITS:-1}
max=${MAX_COMMITS:-50}
count=$(( RANDOM % (max - min + 1) + min ))

for i in $(seq 1 "$count"); do
  line=$(shuf -n 1 scripts/lines.txt)
  stamp=$(date -u +"%Y-%m-%d %H:%M:%S")
  hash=$(head -c 4 /dev/urandom | od -An -tx1 | tr -d ' \n')
  echo "- \`$stamp\` \`$hash\` $line" >> log.md
  git add log.md
  git commit -q -m "$line"
done

echo "made $count commit(s)"
