#!/bin/sh -e

REDMINE_VERSION=2.5-stable


if [ ! -d /redmine/app ] ; then
  cd /
  git clone -b ${REDMINE_VERSION} https://github.com/redmine/redmine.git redmine
fi


cd /redmine
mv /assets/database.yml config/
mv /assets/configuration.yml config/

bundle install --without development tests --path vendor/bundle

mkdir -p tmp tmp/pdf public/plugin_assets
chmod -R 755 files log tmp public/plugin_assets

bundle exec rake generate_secret_token
RAILS_ENV=production bundle exec rake db:migrate
RAILS_ENV=production bundle exec rake tmp:cache:clear
RAILS_ENV=production bundle exec rake tmp:sessions:clear


cd plugins
if [ ! -d /redmine/plugins/redmine_local_avatars ] ; then
  git clone https://github.com/luckval/redmine_local_avatars.git
fi
if [ ! -d /redmine/plugins/redmine_niko_cale ] ; then
  git clone https://github.com/luckval/redmine_niko_cale.git
fi
if [ ! -d /redmine/plugins/redmine_scmacros ] ; then
  git clone https://github.com/luckval/redmine_scmacros.git
fi
if [ ! -d /redmine/plugins/wiki_external_filter] ; then
  git clone https://github.com/luckval/wiki_external_filter.git
  ln -sf /redmine/plugins/wiki_external_filter/config/wiki_external_filter.yml /redmine/config/wiki_external_filter.yml
fi


bundle install

RAILS_ENV=production bundle exec rake redmine:plugins:migrate
