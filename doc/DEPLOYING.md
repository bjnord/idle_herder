# Repo Management and Deploying

Capistrano is configured so that deploying to the `production` target uses the `production` GitHub branch.

## Merging latest changes from master to production branch

        $ git co production
        $ git merge master [ --ff-only ]

_Note:_ Push with `--set-upstream` the first time; then after that you can omit `origin production`:

        $ git push [ origin production ]

## Deploying to production target

        $ cap production rvm:check
        $ cap production deploy      # or deploy:update_code

Use `deploy:update_code` to do a test deploy without changing the `current` symlink or restarting Puma.

## Initial host setup

### Creating PostgreSQL user (role) and database

        postgres$ createuser -P herder
        postgres$ createdb -O herder herder
        postgres$ vi pg_hba.conf
        [ensure "herder" user (role) can access "herder" database]

### Installing prerequisite packages

        [add Yarn and NodeJS repositories, then:]
        # yum install yarn nodejs gnupg2

### Creating the herder user

        # useradd -c "Idle Herder" -m -s /bin/bash -U herder
        # install -o herder -g herder -m 0700 -d /home/herder/.ssh
        # install -o herder -g herder -m 0600 id_rsa.pub /home/herder/.ssh/authorized_keys

        herder$ vi ~/.bash_profile
        [ensure ~/.bashrc is sourced]

        herder$ vi ~/.bashrc
        [add local directories to PATH]
        [export environment variables: RACK_ENV RAILS_ENV SECRET_KEY_BASE DATABASE_URL]

### Installing RVM (in user mode)

        herder$ gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
        herder$ \curl -sSL https://get.rvm.io | bash -s stable
        herder$ rvm autolibs fail
        herder$ rvm install 2.4.1
        herder$ gem install bundler -v1.15.4

