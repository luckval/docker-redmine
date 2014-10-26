docker-redmine
==============

Dockerfile for [redmine](http://www.redmine.org/)

### About

- Redmine 2.5-stable
    - Ruby 2.1
    - MySql
    - ImageMagick
    - Git, Subversion


- Plugin
    - [redmine_local_avatars](https://github.com/luckval/redmine_local_avatars.git)
    - [redmine_niko_cale](https://github.com/luckval/redmine_niko_cale.git)
    - [redmine_scmacros](https://github.com/luckval/redmine_scmacros.git)
    - [wiki_external_filter](https://github.com/luckval/wiki_external_filter.git)


### Quick Start
```
$ git clone https://github.com/luckval/docker-redmine.git
$ cd docker-redmine
$ ./scripts/build.sh
$ ./scripts/setup.sh
$ ./scripts/run.sh
```

### Detail Usage

#### Build
```
$ git clone https://github.com/luckval/docker-redmine.git
$ cd docker-redmine
$ sudo docker build -t $USER/mysql mysql
$ sudo docker build -t $USER/redmine .
```

#### Setup
```
$ sudo docker run -d --name mysql --rm -v /var/lib/mysql $USER/mysql
$ sudo docker run -it --name redmine --rm -v `pwd`/data/redmine:/redmine --volume-from mysql $USER/redmine /assets/setup.sh
```

#### Run
```
$ sudo docker run -it --name redmine --rm -v `pwd`/data/redmine:/redmine -p 80:80 \
        --volume-from mysql $USER/redmine bundle exec rails s -p 80 -e production
```
