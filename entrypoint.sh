#!/bin/sh
set -eu

# Start redis in the background
redis-server \
  --protected-mode no \
  --bind 127.0.0.1 \
  --port 6379 \
  --save "" \
  --appendonly no \
  --daemonize yes

# Wait until it's ready
i=0
while ! redis-cli -h 127.0.0.1 -p 6379 ping >/dev/null 2>&1; do
  i=$((i + 1))
  if [ "$i" -gt 50 ]; then
    echo "redis failed to start" >&2
    redis-cli shutdown nosave >/dev/null 2>&1 || true
    exit 1
  fi
  sleep 0.1
done

# Run the reproducer (default)
php /root/reproducer.php "$@"
rc=$?

# Shut down redis
redis-cli -h 127.0.0.1 -p 6379 shutdown nosave >/dev/null 2>&1 || true

exit "$rc"
