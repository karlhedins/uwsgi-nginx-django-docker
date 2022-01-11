#! /usr/bin/env bash

echo "Running script /app/prestart.sh..."

python manage.py collectstatic --noinput
python manage.py migrate
