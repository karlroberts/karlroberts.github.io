---
layout: post
title: "Working with Terraform Remote Statefile"
date: 2015-09-01 11:04:11 +1000
comments: true
categories: 
- terraform
- gotcha
- remote
- devops
---
#### Remote state
There are gotcha's when working with remote state in terraform that this blog attempts to explain and workaround.

[Terraform](https://www.terraform.io/docs/index.html)  is a pretty cool infrastructure provisioner.
It lets me set up infrastructure that can span cloud providers, eg AWS and/or Azure.

#### working with terraform
By writing terraform config files you declaritivly describe the infrastructure that you want,
for example which AWS IAM users, groups, roles and policies on which S3 buckets and EC2 instances.

by running `terraform plan` terraform create a terraform.tfstate file that describes the full state as described in your config
and compares it to the previous tfstate file to show you what changes will be made.

This is cool, you can see what will happen before you run `terraform apply`.

#### What's the catch?
It is important to realise that terraform is a state machine.

if your previous state added a user, and your new state does not mention that user (ie you removed him from one of the config files) then next time you run `terraform plan` or `terraform apply` you will see that the user will be removed so that the terraformed environment matches the new desired state.

That doesn't seem so bad. Your config (which I presume you are version controlling in git?) grows and consistently matches the desired end stateof your environment, effectivly documenting the infrastructure. Cool.

So what's the problem?

#### The problem
What happens when your mate runs apply from his dev machine?

Obviously terraform will apply the state to the environment as described in his config.
But what if he deletes something that you are still depending on? You can quite quickly destroy each others infrastructure.

This can be avoided using normal Version control practice, eg rebasing from git before you run `terraform plan` and `terraform apply` but almost enevitably you will always be merging conflicts by hand in the `terraform.tfstate` JSON file. This is not too bad if you always have a conflict as you'll know that you need to merge, but as with all structured text files it's possible that a clause will be inserted at a different line to your changes that doesn't conflict in a diff sense but does change the meaning of the file in an inconsitent way, ege a group gould be removed from one place but depended on in another. terraform will fail in this case but then you'll need to manually fix it up, which is a pain, but I can imagine changes that could happen that would not be conflicts and dont screw up the file, but do dramatically impact the generated infrastucture, such as adding a policy or group that together work to lower the expected security contraints of the infrastructure.

##### How do we deal with this?
Terraform handles this scenario by allowing a Remote statefile, that can live in Consul, AWS S3 or Atlas.

Running the `terraform remote` command can set up your local terraform.tfstate file to match the remote one before seeing what the diffs are.

__Gotcha 1__ NB even with a remote statefile terraform does not support concurrent `terraform apply` commands as it doesn't manage locking of the stanza's in the statefile, so talk to your mate before running it!

This is all OK now.... or is it?

There are still a couple of anoying problems that prevent this feature working as you'd expect.

The way I'd like to work with this, is prevent git from commiting the `.terraform/terraform.tfstate` file in the gitignore file, so that the remote one is auto downloaded to compare with my generated new state before calulateing the combined next state.

__Gotcha 2__ If you don't have a local `terraform.tfstate` file then `terraform apply` fails beacuse it assumes it needs to create resources that already may already exist but it doesn't know because it doesn't have the current state.


#### The workaround
You could fetch the latest remote state file and copy it to `.terraform/terraform.tfstate` the first time, but this means you be forever explaining to people what to do.

my current recommendation is to use a Makefile to run terraform, which by default sets up the copy of remote state if it doesn't exist and then runs `terraform plan` with a seperate target for `terraform apply`. 

In this way you don't need to check in the statefile so you cna be sure that you are in sync and you don't need to remember to get it first (Chicken and Egg scenario)

here is the Makefile using and AWS bucket for this terraform remote state:-

```
# Makefile to kick of the terraform for this project
#
# You should set the following environment variable to authenticate 
# with AWS so you can store and retrieve the remote state befor you run this Makefile.
#
# export AWS_ACCESS_KEY_ID= <your key>
# export AWS_SECRET_ACCESS_KEY= <your secret>
# export AWS_DEFAULT_REGION= <your bucket region eg ap-southeast-2>
# export TF_VAR_access_key=$AWS_ACCESS_KEY # exposed as access_key in the terraform scripts
# export TF_VAR_secret_key=$AWS_SECRET_ACCESS_KEY
#
# ####################################################
#
STATEBUCKET = my-statefile-bucket-name
PREFIX = myterraformprojectname

# # Before we start test that we have the manditory executables avilable
 EXECUTABLES = git terraform
 K := $(foreach exec,$(EXECUTABLES),\
 	$(if $(shell which $(exec)),some string,$(error "No $(exec) in PATH, consider apt-get install $(exec)")))
#
# 	.PHONY: all s3bucket plan


.PHONY: all plan apply

all: init.txt plan
	echo "All"

plan: 
	@echo "running terraform plan"
	terraform plan

apply:
	@echo running terraform apply
	terraform apply

# little hack target to prevent it running again without need
# for second nested Makefile
init.txt:
	@echo "initialise remote statefile"
	terraform remote config -backend=s3 -backend-config="bucket=terrastate" -backend-config="key=$(PREFIX)/terraform.tfstate"
	echo "ran terraform remote config -backend=s3 -backend-config=\"bucket=$(STATEBUCKET)\" -backend-config=\"key=$(PREFIX)/terraform.tfstate\"" > ./init.txt
```

here is the .gitignore file
```
*.swp
.terraform/terraform.tfstate*
init.txt
```

here is the terraform config to set up remote state, remote.tf :-
```
# found from env var TF_VAR_acces_key
variable "access_key" {}

variable "secret_key" {}

provider "aws" {
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    region = "ap-southeast-2"
}

resource "terraform_remote_state" "remote_state" {
    backend = "s3"
    config {
      bucket = "my-statefile-bucket-name"
      key    = "myterraformprojectname/terraform.tfstate"
     # region = "ap-southeast-2"
    }
}

```


##### Usage
```
# run 'terraform plan'
make
```
```
# run 'terraform apply'
make apply
```



