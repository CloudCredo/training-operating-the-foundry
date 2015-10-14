# Steps for preparing a new `bosh-lite-with-cf-215` box

* Edit Vagrantfile, uncomment `#Ubuntu 14.04 VM with BOSH lite installed` section, comment `Pre-Provisioned bosh-lite-with-cf-215` section

```bash
vagrant up && vagrant ssh
bosh upload stemcell https://bosh.io/d/stemcells/bosh-warden-boshlite-ubuntu-trusty-go_agent?v=389
bosh upload release /vagrant/cf-215.tgz
~/releases/fetch_releases
cd ~/releases/logsearch-boshrelease && bosh create release
sudo gem install bundler # Not sure why this is needed; bundler is already installed.
cd ~/releases/logsearch-for-cloudfoundry && bosh create release
sudo -i
/vagrant/_setup/prepare_vagrant_box_for_packaging
exit
exit
vagrant package
mv package.box _setup/bosh-lite-with-cf-215.box
```

* Edit Vagrantfile, reversing changes by comment `#Ubuntu 14.04 VM with BOSH lite installed` section, uncomment `Pre-Provisioned bosh-lite-with-cf-215` section
