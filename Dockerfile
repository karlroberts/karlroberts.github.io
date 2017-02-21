FROM ubuntu:xenial-20160914

RUN apt-get update -y && apt-get -y install \
  zlib1g-dev build-essential libssl-dev openssl libreadline-dev libyaml-dev libsqlite3-dev sqlite3 \
  libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev \
  python2.7 python-pip python-dev \
  openssh-server \
  git \
  sudo \
  vim less \
  curl wget


# set up ssh server run space
RUN mkdir -p /var/run/sshd
RUN chmod 700 /var/run/sshd

# Add vagrant user and passwd and insecure vagrant key
# change root passwd to vagrant
RUN ["/bin/bash", "-c" ,"echo -e \"vagrant\\nvagrant\" | passwd"]

# create vagrant user and add ssh keys
RUN useradd -m -s /bin/bash vagrant

# set vagrant passwd to vagrant
RUN ["/bin/bash", "-c" ,"echo -e \"vagrant\\nvagrant\" | passwd vagrant"]

# add vagrant insecure key so you can simple log into the box with 'vagrant ssh'
RUN mkdir -p /home/vagrant/.ssh
RUN chmod 700  /home/vagrant/.ssh
ADD vagrant.pub  /home/vagrant/.ssh/authorized_keys
RUN chmod 600 /home/vagrant/.ssh/authorized_keys
ADD ssh_config /home/vagrant/.ssh/config
RUN chmod 600 /home/vagrant/.ssh/config
RUN chown -R vagrant:vagrant /home/vagrant/.ssh

# all vagrant use to sudo to root
RUN echo "vagrant ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN mkdir -p /usr/local/bin

RUN echo -e "#!/bin/bash \n\
service ssh restart\n\
top -b " \
 >> /usr/local/bin/launch

RUN chmod a+x /usr/local/bin/launch

ADD docker_locale /etc/default/locale
RUN locale-gen en_AU.UTF-8
RUN touch /root/.bashrc



EXPOSE 5432
EXPOSE 4000
EXPOSE 443

# install octopress stuff
USER vagrant
RUN cd /home/vagrant
RUN git clone git://github.com/sstephenson/rbenv.git /home/vagrant/.rbenv
RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> /home/vagrant/.bashrc
RUN echo 'eval "$(rbenv init -)"' >> /home/vagrant/.bashrc
RUN exec $SHELL

RUN git clone https://github.com/rbenv/ruby-build.git /home/vagrant/.rbenv/plugins/ruby-build
RUN echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"'  >> /home/vagrant/.bashrc
RUN exec $SHELL
RUN /bin/bash -c "source /home/vagrant/.bashrc"

RUN cd /home/vagrant
RUN /bin/bash -c "source /home/vagrant/.bashrc && $HOME/.rbenv/bin/rbenv install 2.3.1"
RUN cd /home/vagrant
RUN /bin/bash -c "source /home/vagrant/.bashrc && $HOME/.rbenv/bin/rbenv global 2.3.1"
RUN cd /home/vagrant

USER vagrant
RUN /bin/bash -c "source /home/vagrant/.bashrc && $HOME/.rbenv/shims/gem install bundler"

RUN /bin/bash -c "source /home/vagrant/.bashrc && $HOME/.rbenv/bin/rbenv rehash"


RUN mkdir /home/vagrant/blog
RUN mkdir /home/vagrant/ussh
RUN ln -s /home/vagrant/ussh/id_rsa /home/vagrant/.ssh/id_rsa
#RUN chmod 500 /home/vagrant/.ssh/id_rsa

USER root
VOLUME /home/vagrant/blog
VOLUME /home/vagrant/ussh



ENTRYPOINT ["/bin/sh", "/usr/local/bin/launch"]

