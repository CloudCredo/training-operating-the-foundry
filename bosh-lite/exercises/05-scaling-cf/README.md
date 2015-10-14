## [ 05 - scaling-cf ](#/1)

```nohighlight
As a CF operator
I can scale CF
So that more app instances can be deployed
```


<section style="position: absolute; bottom:0; font-size: 0.5em; text-align: center">
This content is copyright of CloudCredo.<br>
© CloudCredo 2015. All rights reserved.
</section>

---

## [ More RAM, more redundancy ](#/1)

* Scale up - larger VMs for DEAs
* Scale out - more DEA VMs (also more redundancy)
* Manifest - cluster configuration
  * scale up by changing VM spec - `resource_pools:`
  * scale out by having more job instance VMs - `jobs['name'].instances:` 

---

## [ Edit the manifest to scale out ](#/1)

* Get deployed manifest

```bash
cd ~/exercises/05-scaling-cf
bosh deployments
bosh download manifest cf-warden > cf-deployment.yml
```

* Edit cf-deployment.yml, increment instances

```bash
nano ~/exercises/05-scaling-cf/cf-deployment.yml
^W runner_z1
```

* Deploy change

```bash
bosh deployment cf-deployment.yml
bosh deploy
bosh vms # 2 x runner
```

---

## [ App instances distributed over DEAs ](#/1)

```bash
cf scale myapp -i 5
cf app myapp
```

* CF is distributing app instances across available runners

---

## [ Scale down ](#/1)

* Edit cf-deployment.yml, decrement instances

```bash
nano cf-deployment.yml
^W runner_z1
```

* Deploy change

```bash
bosh deploy
bosh vms # only 1 x runner
```

---

# <span style="color: #8FF541;">DELIVERED</span>

```nohighlight
As a CF operator
I can scale CF
So that more app instances can be deployed
```

---

## [ Further reading ](#/3)

* Canaries & max-in-flight
  * https://bosh.io/docs/deployment-manifest.html#update
  * https://bosh.io/docs/terminology.html#canary
* Drain scripts
  * http://bosh.io/docs/drain.html
* Availability Zones (becoming a feature)
  * https://github.com/cloudfoundry/bosh-notes/blob/master/availability-zones.md

---

<section style="position: absolute; bottom:0; font-size: 0.5em; text-align: center">
This content is copyright of CloudCredo.<br>
© CloudCredo 2015. All rights reserved.
</section>