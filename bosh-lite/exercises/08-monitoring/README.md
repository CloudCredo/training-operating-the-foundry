## [ 08 - monitoring (BONUS) ](#/1)

```nohighlight
As an advanced CF operator
I can monitor my CF cluster
So that I know about problems before they affect my users
```


<section style="position: absolute; bottom:0; font-size: 0.5em; text-align: center">
This content is copyright of CloudCredo.<br>
© CloudCredo 2015. All rights reserved.
</section>

---

## [ Logsearch-for-CloudFoundry ](#/1)

* Adds integrated log analysis to the CF platform
* BOSH deployed Elastic ELK stack customised to understand CF
* For CF operators
  * CF component logs
  * CF component metrics
* For CF apps
  * CF app logs
  * CF app metrics

---

## [ Building a release .tgz ](#/1)

* `release.tgz` built from bosh-release git repository

```bash
~/releases/fetch_releases
```

```bash
~/releases/logsearch-for-cloudfoundry
  └── logsearch-for-cloudfoundry
     ├── blobs
     ├── config
     ├── jobs
     ├── packages
     ├── src
     ├── templates
     └── generate_deployment_manifest
```

```bash
cd ~/releases/logsearch-boshrelease
bosh create release
bosh upload release
```

```bash
cd ~/releases/logsearch-for-cloudfoundry
bosh create release
bosh upload release
```

---

### [ Deploy Logsearch-for-Cloudfoundry ](#/1)

```bash
cd ~/exercises/08-monitoring
~/releases/logsearch-for-cloudfoundry/generate_deployment_manifest \
warden logsearch-stub.yml > logsearch-deployment.yml
bosh deployment logsearch-deployment.yml
bosh -n deploy
bosh run errand push-kibana
```

```bash
# In new terminal on host PC
bosh-lite/_setup/add_route 
```

---

## [ Analysing platform metrics ](#/1)

* http://logs.10.244.0.34.xip.io

* http://docs.pivotal.io/pivotalcf/opsguide/metrics.html

---

# <span style="color: #8FF541;">DELIVERED</span>

```nohighlight
As a CF operator
I can monitor my CF cluster
So that I know about problems before they affect my users
```

---

## [ Further reading ](#/3)

* github.com/logsearch/logsearch-for-cloudfoundry
* logsearch.io
* https://github.com/cloudfoundry-community/bosh-gen
* https://github.com/pivotal-cf-experimental/datadog-config-oss


---

<section style="position: absolute; bottom:0; font-size: 0.5em; text-align: center">
This content is copyright of CloudCredo.<br>
© CloudCredo 2015. All rights reserved.
</section>