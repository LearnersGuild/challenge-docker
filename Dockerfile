# This is the base image for Learners Guild challenges. It can be run locally or
# in the cloud (e.g., via something like tutum.co + Floobits).
#
# It's worth noting that this image might want to be broken up into several
# images based on the language / framework / stack being used.

FROM ubuntu:trusty
MAINTAINER jeffrey@learnersguild.org

# make sure apt is up to date
RUN apt-get update

# install baseline development environment
RUN DEBIAN_FRONTEND=noninteractive apt-get install -yy --no-install-recommends \
  build-essential \
  ca-certificates \
  curl \
  git \
  git-core \
  libcurl4-openssl-dev \
  libffi-dev \
  libqt4-dev \
  libreadline-dev \
  libsqlite3-dev \
  libssl-dev \
  libxml2-dev \
  libxslt1-dev \
  libyaml-dev \
  postgresql \
  postgresql-contrib \
  python \
  python-dev \
  python-pip \
  python-software-properties \
  sqlite3 \
  tmux \
  vim \
  wget \
  zlib1g-dev

# set up node.js and npm
RUN DEBIAN_FRONTEND=noninteractive apt-get install -yy --no-install-recommends \
  nodejs \
  npm
RUN ln -s /usr/bin/nodejs /usr/bin/node

# make image smaller
RUN apt-get clean

# set up rbenv, ruby-build, and ruby
RUN useradd -ms /bin/bash dev
USER dev
WORKDIR /home/dev
RUN pwd
RUN git clone git://github.com/sstephenson/rbenv.git ~/.rbenv
RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
RUN echo 'eval "$(rbenv init -)"' >> ~/.bashrc
RUN exec $SHELL
RUN git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
RUN echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
RUN exec $SHELL
RUN git clone git://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash
RUN echo $PATH
RUN ~/.rbenv/bin/rbenv install 2.2.3
RUN ~/.rbenv/bin/rbenv rehash

# set up a bogus shared development environment
RUN mkdir -p /home/dev/workdir/foo
WORKDIR /home/dev/workdir/foo
RUN echo '# Here is the README' > /home/dev/workdir/foo/README.md

USER root
WORKDIR $HOME

# install Floobits tools
RUN npm install -g floomatic
RUN pip install flootty

# start the Floobits tools
USER dev
COPY .floorc.json /home/dev/.floorc.json
# HACK: change this timestamp to let 'docker build' recognize changes if start.sh changes
RUN echo 01234543210
COPY start.sh /home/dev/start.sh
WORKDIR /home/dev/workdir/foo
CMD /home/dev/start.sh
