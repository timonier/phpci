# README

⚠️ This project is no longer maintained. ⚠️

## Usage

An example of usage is provided with `docker-compose`:

```sh
# Override docker-compose

cat > docker-compose.override.yml << "EOF"
version: '2.3'

services:
    master:
        environment:
            - 'PHPCI_DB_PASSWORD=${PHPCI_DB_PASSWORD}'
        ports:
            - '80:80'

    mysql:
        environment:
            - 'MYSQL_PASSWORD=${PHPCI_DB_PASSWORD}'
            - 'MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}'

    worker:
        environment:
            - 'PHPCI_DB_PASSWORD=${PHPCI_DB_PASSWORD}'
EOF

# Prepare the system

export MYSQL_ROOT_PASSWORD="96bb5db7-0f0f-4758-af6f-c8dd4a9fe058"
export PHPCI_DB_PASSWORD="6e737f0e-8641-4894-8d74-87d161841bc6"

# Start the project

docker-compose up -d

# Create an admin

docker-compose exec --user www-data master php /opt/phpci/console phpci:create-admin

# Increase (or decrease) the number of workers

docker-compose scale worker=2

# Go to the URL "localhost"
```

__Note__: Don't forget to change the MySQL password. Use `bin/generate-secret` if you want to generate a strong token.

## Links

* [docker-compose](https://docs.docker.com/compose/)
* [image "timonier/beanstalkd"](https://hub.docker.com/r/timonier/beanstalkd/)
* [image "timonier/mysql"](https://hub.docker.com/r/timonier/mysql/)
* [image "timonier/php"](https://hub.docker.com/r/timonier/php/)
* [image "timonier/phpci"](https://hub.docker.com/r/timonier/phpci/)
* [phpci](https://www.phptesting.org/)
* [timonier/dumb-entrypoint](https://github.com/timonier/dumb-entrypoint)
* [timonier/version-lister](https://github.com/timonier/version-lister)
* [s6-overlay](https://github.com/just-containers/s6-overlay)
* [syslog-stdout](https://github.com/timonier/syslog-stdout)
