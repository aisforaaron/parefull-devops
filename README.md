# Parefull Devops

This is the vagrant/ansible project part of Parefull.

See full setup instructions on the parefull-heroku project.


## General


* start nodejs server
```$ DEBUG=helloworld:* npm start```

* To refresh collections with test data
  $ cd provisioning/roles/mongodb/
  $ mongoimport --db local --collection bits --drop --file parefull-bits-testdata.json
  $ mongoimport --db local --collection scores --drop --file parefull-scores-testdata.json


## Stack References

* [Ansible](https://docs.ansible.com/ansible/index.html)
* [Vagrant](https://docs.vagrantup.com/v2/)
  * [NFS Share](https://docs.vagrantup.com/v2/synced-folders/nfs.html)
* [VirtualBox](https://www.virtualbox.org/wiki/Documentation)
* [Nodemon](https://github.com/remy/nodemon)
* [Foreverjs](https://github.com/foreverjs/forever)
  * [initd-forever](https://www.npmjs.com/package/initd-forever)