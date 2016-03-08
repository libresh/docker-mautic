#!/bin/bash
set -e

if [ ! -e offline.php ]; then
	tar cf - --one-file-system -C /usr/src/mautic . | tar xf -
	chown -R www-data .
fi

exec "$@"
