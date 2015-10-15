## [ 07 - updating-stemcells ](#/1)

```nohighlight
As a CF operator
I can patch my CF cluster's base OS images
So that my users apps aren't vulnerable to security CVEs
```

<section style="position: absolute; bottom:0; font-size: 0.5em; text-align: center">
This content is copyright of CloudCredo.<br>
© CloudCredo 2015. All rights reserved.
</section>

---

## [ Updating stemcell ](#/1)

* Download new stemcell from bosh.io

```bash
cd ~/exercises/07-updating-stemcells
bosh upload stemcell bosh-stemcell-2776-warden-boshlite-ubuntu-trusty-go_agent.tgz
```

* Update manifest stub

```bash 
cat cf-redis-stub.yml
```

* Generate and deploy

```bash
~/releases/cf-redis-release/generate_deployment_manifest \
warden cf-redis-stub.yml > cf-redis-deployment.yml
bosh deployment ./cf-redis-deployment.yml
bosh deploy
```

---

## [ What's happening ](#/1)

* Recompiles packages for/on new stemcell
* Rolls through cluster recreating jobs 
* Boring... - wait 20 min

---

## [ When to upgrade ](#/1)

* Releases recommend stemcell versions
  * https://github.com/cloudfoundry/cf-release/releases/tag/v217#recommended-bosh-release-and-stemcell-versions
* Base OS security patches - Heartbleed

---

# <span style="color: #8FF541;">DELIVERED</span>

```nohighlight
As a CF operator
I can patch my CF cluster's base OS images
So that my users apps aren't vulnerable to security CVEs
```

---

<section style="position: absolute; bottom:0; font-size: 0.5em; text-align: center">
This content is copyright of CloudCredo.<br>
© CloudCredo 2015. All rights reserved.
</section>
