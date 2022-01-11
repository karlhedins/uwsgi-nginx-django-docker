FROM tiangolo/uwsgi-nginx:python3.9

COPY ./requirements.txt /app/requirements.txt

RUN pip install --no-cache-dir --upgrade -r /app/requirements.txt

# uwsgi config file to override the tiangolo/uwsgi-nginx defaults
ENV UWSGI_INI /app/app/uwsgi.ini

# Copy the entrypoint that will generate Nginx additional configs
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# URL for static files served by Nginx directly, without being handled by uWSGI
ENV STATIC_URL /static
# Absolute path for where the static files are located
ENV STATIC_PATH /app/static_collected

COPY ./app /app
WORKDIR /app

# Make /app/* available to be imported by Python globally to better support several use cases for packages that need it
ENV PYTHONPATH=/app