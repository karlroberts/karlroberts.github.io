#!/bin/bash
CWD=`pwd`
cd $CWD

export ANSIBLE_SSH_PIPELINING=1
export ANSIBLE_CONFIG=$CWD/vars/vagrant/ansible.cfg

RELOAD=""

while [[ $# -gt 1 ]]
do
  key="$1"

  case $key in
      -r|--reload)
        RELOAD="true"
        ;;
      *)
              # unknown option
      ;;
  esac
  shift # past argument or value
done

if [ -z ${RELOAD} ];
then
  echo "RELOAD flag is unset";
  vagrant up --provision --provider=docker
else
  echo "RELOAD flag is set to '$RELOAD'";
  vagrant reload --provision
fi
