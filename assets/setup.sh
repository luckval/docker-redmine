#!/bin/sh -e

REDMINE_VERSION=2.5-stable
MEMCACHE_HOST=xxx
MEMCACHE_PORT=xxx

[ -d /redmine/file ] && exit 0

cd /
git clone -b ${REDMINE_VERSION} https://github.com/redmine/redmine.git redmine

cd /redmine

cat > config/database.yml <<EOF
production:
  adapter: mysql2
  database: redmine
  host: localhost
  username: redmine
  password: redmine
  encoding: utf8
EOF

cat > config/additional_environment.rb <<EOF
config.gem 'dalli'
config.action_controller.perform_caching  = true
config.cache_classes = true
config.cache_store = :dalli_store, "${MEMCACHE_HOST}:${MEMCACHE_PORT}"
EOF

cat > config/configuration.yml <<EOF
production:
  email_delivery:
    delivery_method: :async_smtp
    smtp_settings:
      address: "localhost"
      port: 25
      domain: 'example.com'

  rmagick_font_path: /usr/share/fonts/ipa-pgothic/ipagp.ttf
EOF

bundle install --without development tests --path vendor/bundle

mkdir -p tmp tmp/{pdf,pids,sockets}
chmod 755 files

bundle exec rake generate_secret_token
RAILS_ENV=production bundle exec rake db:migrate
RAILS_ENV=production bundle exec rake tmp:cache:clear
RAILS_ENV=production bundle exec rake tmp:sessions:clear

cd plugins
git clone https://github.com/luckval/redmine_local_avatars.git
git clone https://github.com/luckval/redmine_niko_cale.git
git clone https://github.com/luckval/redmine_scmacros.git
git clone https://github.com/luckval/wiki_external_filter.git

RAILS_ENV=production bundle exec rake redmine:plugins:migrate
