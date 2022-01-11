# About

This repo contains an example Docker image running a Django applicatoin with uWSGI and NGINX serving static files within one Docker container.
The base image and main inspiration repos for the setup are [uwsgi-nginx-docker](https://github.com/tiangolo/uwsgi-nginx-docker) and [uwsgi-nginx-flask-docker](https://github.com/tiangolo/uwsgi-nginx-flask-docker).

This setup could be a suitable fit for when running on a single server with docker-compose. For more information, see [this excellent post](https://fastapi.tiangolo.com/deployment/docker/#docker-compose) from FastAPI on this.

Key points of this setup:

- NGINX for static files, uWSGI for the Django app
- Supervisord manages uWSGI and NGINX processes within the container
- Sane default configurations thanks to [uwsgi-nginx-docker](https://github.com/tiangolo/uwsgi-nginx-docker)
- Configurable number of processes for uWSGI and Django by env variables, so that you don't have to rebuild the container when changing these.

Here is a list of env variables that can be set to dynamically configure the container at run time in `docker-compose.yml`, or if preferred at buildtime in `Dockerfile`.

```
# Maximum upload file size for Nginx, default to 0: unlimited
NGINX_MAX_UPLOAD

# Number of workers for Nginx, default to 1
NGINX_WORKER_PROCESSES

# Max number of connections per worker for Nginx, if requested
# Cannot exceed worker_rlimit_nofile, see NGINX_WORKER_OPEN_FILES in entrypoint.sh, default to 1024
NGINX_WORKER_CONNECTIONS

# Min number of uWSGI processes, default to 2
UWSGI_CHEAPER

# Max number or uWSGI processes, defaults to 16
# When the server is experiencing a high load, it creates up to 16 uWSGI processes to handle it on demand.
UWSGI_PROCESSES

# Listen port for Nginx, default to 80
LISTEN_PORT

# Get the URL for static files, default to /static
STATIC_URL

# Absolute path of the static files, default to /app/static
STATIC_PATH
```

The following files can be used for configuration:

- If there's a `prestart.sh` script in the /app directory of the container it will be run before starting the application.
- `entrypoint.sh` - entrypoint file for the container that dynamically generetates the nginx config
- `app/app/uwsgi.ini` - uwsgi configurations to override the [uwsgi-nginx-docker](https://github.com/tiangolo/uwsgi-nginx-docker) defaults

# Setup

Make sure you have:

- Docker
- Docker-compose

Build the cointainer:

```
docker-compose build
```

Run the container:

```
docker-compose up
```

NOTE: this setup does not have any live reloading of files, so remember to rebuild the container if changing any of the source files.

Go to the URL http://localhost/polls/

If the link text of `Some link` is green that means that the configuration of the static files is working, since that is set by a static CSS file.
If the link is blue, which is the default, check your static file configuration.
