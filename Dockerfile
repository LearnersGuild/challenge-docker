# This is the base image for Learners Guild challenges. It can be run locally or
# in the cloud (e.g., via something like tutum.co + Floobits).
#
# It's worth noting that this image might want to be broken up into several
# images based on the language / framework / stack being used.

FROM ubuntu:trusty
MAINTAINER jeffrey@learnersguild.org

# use bash instead of standard sh
RUN ln -snf /bin/bash /bin/sh

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

# make image smaller
RUN apt-get clean

# development user
RUN useradd -ms /bin/bash dev
USER dev
ENV HOME /home/dev
WORKDIR $HOME

# set up nvm, node.js and npm
ENV NVM_DIR $HOME/.nvm
ENV NODE_VERSION 4.2.2
RUN git clone https://github.com/creationix/nvm.git $NVM_DIR && \
    cd $NVM_DIR && \
    git checkout `git describe --abbrev=0 --tags`
RUN source $NVM_DIR/nvm.sh && \
    nvm install $NODE_VERSION && \
    nvm alias default $NODE_VERSION && \
    nvm use default
RUN echo "source ${NVM_DIR}/nvm.sh" >> $HOME/.bashrc && \
    source $HOME/.bashrc
ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# set up rbenv, ruby-build, and ruby
ENV RBENV_DIR $HOME/.rbenv
ENV RUBY_VERSION 2.2.3
RUN git clone git://github.com/sstephenson/rbenv.git $RBENV_DIR
RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> $HOME/.bashrc && \
    echo 'eval "$(rbenv init -)"' >> $HOME/.bashrc && \
    source $HOME/.bashrc
RUN git clone git://github.com/sstephenson/ruby-build.git $HOME/.rbenv/plugins/ruby-build
RUN echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> $HOME/.bashrc && \
    source $HOME/.bashrc
RUN git clone git://github.com/sstephenson/rbenv-gem-rehash.git $HOME/.rbenv/plugins/rbenv-gem-rehash
ENV PATH $RBENV_DIR/bin:$PATH
RUN rbenv install $RUBY_VERSION && \
    rbenv rehash

# set up a bogus shared development environment
RUN mkdir -p $HOME/workdir
WORKDIR $HOME/workdir
RUN echo '# Here is the README' > $HOME/workdir/README.md

# install Floobits tools
USER root
RUN pip install flootty
USER dev
RUN npm install -g floomatic

# start the Floobits tools
# HACK: change this timestamp to let 'docker build' recognize changes if start.sh changes
RUN echo 45678987654
COPY start.sh $HOME/start.sh
WORKDIR $HOME/workdir
CMD $HOME/start.sh
