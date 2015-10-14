## [ 01 - Deploy ](#/1)

```nohighlight
As a CF operator
I can deploy the Cloud Foundry platform
So that my users can self-serve their app deployment
```

<section style="position: absolute; bottom:0; font-size: 0.5em; text-align: center">
This content is copyright of CloudCredo.<br>
© CloudCredo 2015. All rights reserved.
</section>

---


## [ Cloud on your laptop ](#/1)

* Simulate a cloud on your laptop with BOSH-lite
* cp `<USB>/operating-the-foundry` to your PC

```bash
cd path/to/operating-the-foundry/bosh-lite
vagrant up
```

* Adjust your power settings to prevent your machine going to sleep
  * `_installs/Cafeine1.1.1.zip`
* Wait until ...

```bash
=-=-=-=-=-=-=-=-=-=-=-=-=-=
  BOSH-lite cloud ready
=-=-=-=-=-=-=-=-=-=-=-=-=-=
```

Note:
  Open a terminal

  You might be prompted for your `sudo` password

  see <USB>/operating-the-foundry/_installs/ if you don't have Vagrant or VirtualBox

---

## [ What is a cloud? ](#/2)

* Technical:
  * Virtual infrastructure
    * VMs
    * Networks
    * Disks
  * Driven by an API

* Cultural:
  * Automated, repeatable operations
  * Cattle, not pets

---

## [ What is BOSH? ](#/3)

* BOSH is a cloud orchestration engine 
* BOSH CPI - Cloud Provider Interface
  * `create_vm`, `attach_disk`, `delete_vm` ...
  * for: vSphere | Openstack | AWS | Azure | GCE 
* 1 x BOSH director, n x VMs running BOSH agents

---

## [ What is BOSH-lite? ](#/4)

* VM with BOSH director installed 
* Custom "container" CPI
* Simulate VMs using containers

> ==> Simulate a cloud on your laptop!

---

## [ BOSH philosophy ](#/5)

* Works at cluster level
* Self contained
* Optimised for day 2 forward
 
<div style="text-align:center"><img src="bosh-optimised-for-day2.jpg" height="350" /></div>

---

## [ Cloud on your laptop ](#)

* Back to...

```bash
cd path/to/bosh-lite
vagrant up
```

* should now see

```bash
=-=-=-=-=-=-=-=-=-=-=-=-=-=
  BOSH-lite cloud ready
=-=-=-=-=-=-=-=-=-=-=-=-=-=
```

---

## [Deploy CF to that cloud](#/6)

* Deploy CF to that cloud

```bash
vagrant ssh
deploy_cf
```

* Wait ~15 min until ...

```bash
=-=-=-=-=-=-=-=-=-=-=-=-=-=  
 Cloud Foundry deployed!    
=-=-=-=-=-=-=-=-=-=-=-=-=-=   
```

---

## [ BOSH concepts - Overview](#/7)

* Stemcell.tgz - a mimimal VM image running the BOSH agent
* Release.tgz - a versioned tarball containing ALL the assets that will be deployed
* Manifest.yml - a cluster config file
* Deployment - a cluster of running VMs

> Manifest + Release + Stemcell => Deployment

---

## [ BOSH concepts - Stemcell ](#/8)

* Download for your cloud type from bosh.io/stemcells
* Minimalist Ubuntu/CentOS + BOSH agent
* Uploaded to BOSH director

```bash
vagrant ssh #in a new terminal
bosh stemcells    
```

* Can audit / modify stemcell build process
   * http://bosh.io/docs/build-stemcell.html

---

## [ BOSH concepts - Releases ](#/9)

* Download from bosh.io/releases
* Tarball contains everything to be deployed; 
   * runtimes (JVM, Ruby...), 
   * services (Redis, CloudController...), 
   * config templates
* Uploaded to BOSH director

```bash
bosh releases    
```

* Compiled from *-boshrelease repos

---

## [ BOSH concepts - Manifest ](#/10)

* Cluster configuration
  * stemcell and release(s) versions 
  * VM & network specification
  * Jobs - software templates to be installed on each VM
  * config values
* YAML (passed through ERB)

---

## [Deploy CF to that cloud](#)

* should now see ...

```bash
=-=-=-=-=-=-=-=-=-=-=-=-=-=  
  Cloud Foundry deployed!    
=-=-=-=-=-=-=-=-=-=-=-=-=-=   
```

---

## [ BOSH concepts - Deployments ](#/11)

* Manifest + Release(s) + Stemcell => Deployment

```bash
bosh deployments    
```

* Deployment => BOSH managed VMs running software configured as cluster

```bash
bosh vms
```

---

## [ Community ](#/11)

* www.cloudfoundry.org - participate!
  * Mailing lists - lists.cloudfoundry.org
  * Repositories - github.com/cloudfoundry, github.com/cloudfoundry-incubator

---

# <span style="color: #8FF541;">DELIVERED</span>

```nohighlight
As a CF operator
I can deploy the Cloud Foundry platform
So that my users can self-serve their app deployment
```

---

## [ Further reading ](#/12)

* Preparing a "real" cloud for BOSH
  * http://bosh.io/docs/init.html 
* bosh-init - deploy BOSH director to manage a "real" cloud
  * http://bosh.io/docs/using-bosh-init.html
* `bosh help`
  * `bosh task recent`, `bosh tasks` & `bosh task <id> --debug`
  * `bosh recreate job`

---

<section style="position: absolute; bottom:0; font-size: 0.5em; text-align: center">
This content is copyright of CloudCredo.<br>
© CloudCredo 2015. All rights reserved.
</section>

