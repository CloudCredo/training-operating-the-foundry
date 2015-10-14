## [ 06 - upgrade-cf-release ](#/1)

```nohighlight
As a CF operator
I can change/upgrade my CF release
To take advantage of new features and security fixes
```


<section style="position: absolute; bottom:0; font-size: 0.5em; text-align: center">
This content is copyright of CloudCredo.<br>
© CloudCredo 2015. All rights reserved.
</section>

---

## [ Upgrading ](#/1)

* BOSH is optimised for day 2 onwards
* Zero downtime 
   * You should be upgrading during working hours
* New CF release ~ every week.
   * https://github.com/cloudfoundry/cf-release/releases

---

## [ When should you upgrade? ](#/2)

* Regularly - generally cannot "skip" versions
* Read release notes
  * https://github.com/cloudfoundry/cf-release/releases/tag/v217
* Releases are dog-fooded on run.pivotal.io 
  * consider waiting 1 week for issues to emerge unless CVE

---

## [ Upload the release ](#/3)

* For reasons of speed, we'll upgrade redis
* Process is the same for all bosh releases

```bash
cd ~/exercises/06-upgrade-release/
bosh upload release cf-redis-release-408.tgz
```

---

## [ Manifest generation ](#/4)

* Most releases ship with a `generate_deployment_manifest` script

* Create a `stub.yml` to override defaults

```bash
cat cf-redis-stub.yml
```

* Generate a full manifest for a specific infrastructure

```bash
~/releases/cf-redis-release/generate_deployment_manifest warden \
cf-redis-stub.yml > cf-redis-deployment.yml
```

* Deploy

```bash
bosh deployment cf-redis-deployment.yml
bosh deploy
```

---

## [ Upgrades are boring with BOSH! ](#/5)

* weeks of manual work is being automated
* provisioning servers, installing based OS, installing services, updating config, updating inventory
* with zero downtime (with full scale deployment)
* during working hours

---

## [ Inside the manifest ](#/5)

* http://bosh.io/docs/deployment-manifest.html
  * `releases`
  * `networks`
  * `resource_pools`
  * `disk_pools`
  * `jobs`
  * `properties`

* Simplifications coming!
  * https://github.com/cloudfoundry/bosh-notes
---

# <span style="color: #8FF541;">DELIVERED</span>

```nohighlight
As a CF operator
I can change/upgrade my CF release
To take advantage of new features and security fixes
```

---

## [ Further reading ](#/3)

* Release notes
  * https://github.com/cloudfoundry/cf-release/releases
* Team trackers
  * https://github.com/cloudfoundry-community/cf-docs-contrib/wiki
  * See `Roadmap and Trackers` sidebar 
* Automated deploy pipelines
  * concourse.ci

---

<section style="position: absolute; bottom:0; font-size: 0.5em; text-align: center">
This content is copyright of CloudCredo.<br>
© CloudCredo 2015. All rights reserved.
</section>

