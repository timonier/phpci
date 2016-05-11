# README

## Installation

Pull the image `timonier/phpci`:

```sh
# Get the latest image (version 1.7.0)
docker pull timonier/phpci

# Or get a specific version

# Get the version 1.7.0
docker pull timonier/phpci:1.7.0
```

## Usage

An example of usage is provided with `docker-compose`:

```sh
# Override docker-compose
cat > docker-compose.override.yml << "EOF"
mysql:
    environment:
        - MYSQL_PASSWORD=6e737f0e-8641-4894-8d74-87d161841bc6
        - MYSQL_ROOT_PASSWORD=96bb5db7-0f0f-4758-af6f-c8dd4a9fe058

phpci:
    ports:
        - "80:80"
EOF

# Start the project
docker-compose up -d

# Initialize (or update) the database
while ! nc -z $(docker inspect --format "{{ .NetworkSettings.IPAddress }}" phpci_mysql_1) 3306 ; do sleep 1 ; done && docker-compose exec --user www-data phpci /bin/sh -c "cd /var/www && ./console phpci:update"

# Download (or update) the PHP tools
docker-compose exec phpci sh -c 'curl -sLo /usr/local/bin/composer https://getcomposer.org/download/1.1.0/composer.phar && chmod +x /usr/local/bin/composer'
docker-compose exec phpci sh -c 'curl -sLo /usr/local/bin/phpcs https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar && chmod +x /usr/local/bin/phpcs'
docker-compose exec phpci sh -c 'curl -sLo /usr/local/bin/phploc https://phar.phpunit.de/phploc.phar && chmod +x /usr/local/bin/phploc'
docker-compose exec phpci sh -c 'curl -sLo /usr/local/bin/phpmd http://static.phpmd.org/php/latest/phpmd.phar && chmod +x /usr/local/bin/phpmd'
docker-compose exec phpci sh -c 'curl -sLo /usr/local/bin/sami http://get.sensiolabs.org/sami.phar && chmod +x /usr/local/bin/sami'

# Create an admin
docker-compose exec --user www-data phpci /var/www/console phpci:create-admin

# Increase (or decrease) the number of workers
docker-compose scale worker=2

# Go to the URL "localhost"
```

__Note__: Don't forget to change the MySQL password. Use `bin/generate-secret` if you want to generate a strong token.

## Contributing

1. Fork it.
2. Create your branch: `git checkout -b my-new-feature`.
3. Commit your changes: `git commit -am 'Add some feature'`.
4. Push to the branch: `git push origin my-new-feature`.
5. Submit a pull request.

__Note__: Use the script `bin/build` to test your modifications locally.

## Links

* [command "docker pull"](https://docs.docker.com/reference/commandline/pull/)
* [command "docker run"](https://docs.docker.com/reference/run/)
* [docker-compose](https://docs.docker.com/compose/)
* [image "mysql"](https://hub.docker.com/_/mysql/)
* [image "timonier/beanstalkd"](https://hub.docker.com/r/timonier/beanstalkd/)
* [image "timonier/phpci"](https://hub.docker.com/r/timonier/phpci/)
* [phpci](https://www.phptesting.org/)
* [s6-overlay](https://github.com/just-containers/s6-overlay)
* [syslog-stdout](https://github.com/timonier/syslog-stdout)
