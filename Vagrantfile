# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.hostname = "octopress"

  # make sure we use vagrant as ssh user , this is the default but being explicit
  # allows force_remote_user to get a magic ansible_ssh_user in generated inventory file
  # to overide remote_user in playbooks
  config.ssh.username = "vagrant"

  # Disable the new default behavior introduced in Vagrant 1.7, to
  # ensure that all Vagrant machines will use the same SSH key pair.
  # See https://github.com/mitchellh/vagrant/issues/5005
  config.ssh.insert_key = false

  # see thyis blog for understanding docker images on local registry
  # http://karlcode.owtelse.com/blog/2017/01/25/push-a-docker-image-to-personal-repository/
  # you will need to run the following before running vagrant to authenticate the avocado docker repo
  #     docker login docker.aws.avocado.com.au:443
  #
  config.vm.provider "docker" do |d|
    d.build_args = ["--tag=my_octopress"]
    d.name = "my_octopress_name"
    d.has_ssh = true
    # comment below to use local Dockerfile rather than repo image
    #d.image = "docker.aws.avocado.com.au:443/hel/ubuntu-xenial-hel:latest"
    # uncomment below to use local Dockerfile rather than repo image
    d.build_dir = "."
    d.ports = ["4000:4000"]
    d.volumes = ["/home/robertk/projects/octopress:/home/vagrant/blog", "/home/robertk/.ssh:/home/vagrant/ussh" ]
  end

  config.vm.provision "shell" do |s|
    s.inline = "echo Hiya Karl shel prov"
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "provision_vagrant.yml"
    ansible.verbose = "v"
    ansible.groups = {
      "octopress" => ["default"]
    }
  end
end
