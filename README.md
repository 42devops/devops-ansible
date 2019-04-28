## project ansible to provision something

## roles list

- Prometheus
- node_exporter
- blackbox_exporter
- mysql_exporter
- alertmanager
- sec_os and sec_ssh

...

## requirements

- [Vagrant](https://www.vagrantup.com/) \* only if using Vagrant driver
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads) \* only if using Vagrant driver
- [chef workstation](https://www.chef.sh/)
- docker

> the chef workstation including `kitchen` and `inspec`

install kitchen plugin

```
chef gem install kitchen-vagrant #only if using Vagrant driver
chef gem install kitchen-ansible
chef gem install kitchen-docker
```

## Usages

### 1. download packages

download the binaries packages into local `./script/binaries/` dir

```
make download
```

### 2. dist copy packages into ansible files dir

copy all using binarise packages into the roles dir

```
make dist
```

### 3. test

make sure `chef workstation` and `vagrant` installed, all test script in `test/integration/default/` dir

```
## create test env
kitchen create
## prepare env
kitchen converge
## running ansible role which define in test/integration/default/default.yml
kitchen setup
## running test and verify env define in test/integration/default/*.rb
kitchen verify
## destroy all env
kitchen destroy
```

running all step above, Test (destroy, create, converge, setup, verify and destroy) one or more instances

```
kitchen test
```

### 4. startup a local env

```
# using Vagrant driver
vagrant up
# using docker
kitchen create
kitchen converge

kitchen login
```
