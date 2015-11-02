## [ 03 - cf-users-spaces-orgs ](#/1)

```nohighlight
As a CF operator
I can provision a new CF user
So that user can `cf push` their app
```


<section style="position: absolute; bottom:0; font-size: 0.5em; text-align: center">
This content is copyright of CloudCredo.<br>
© CloudCredo 2015. All rights reserved.
</section>

---

## [ CF Orgs&nbsp;&amp;&nbsp;Spaces / Users&nbsp;&amp;&nbsp;Permissions ](#/1)

* Organisations 
   * Quotas
* Spaces
   * Domains
   * Security Groups
   * Services
   * Apps
* Users
   * Roles

---

## [ cf cli ](#/1)

* CLI for interacting with CF

```bash
cf login -a https://api.10.244.0.34.xip.io --skip-ssl-validation
# admin / admin
```

* Help - type in the command with no args

```bash
cf
cf create-org
```

---

## [ CF Orgs ](#/1)

* Create

```bash
cf create-org platform-ops
```

* List

```bash
cf orgs
```

* Details

```bash
cf org platform-ops
```

* Target

```bash
cf target -o platform-ops
```

---

## [ CF Spaces ](#/1)

* Create

```bash
cf create-space 
cf create-space development
```

* List

```bash
cf spaces
```

* Details

```bash
cf space development
```

* Target

```bash
cf target -s development
```

---

## [ CF Users ](#/1)

* Create

```bash
cf create-user
cf create-user <user@email> <password>
```

* Assign

```bash
cf set-org-role
cf set-org-role <user@email> platform-ops OrgManager
cf set-space-role
cf set-space-role <user@email> platform-ops development SpaceDeveloper
```

* List

```bash
cf org-users platform-ops
cf space-users platform-ops development
```

---

## [ CF Apps ](#/3)

* cf push is golden

```bash
cd ~/exercises/03-cf-users-spaces-orgs/app
cf push
curl -s myapp.10.244.0.34.xip.io
```

* Buildpacks - convert code into runable droplet.tgz
* List 

```bash
cf apps
```

* Details

```bash
cf app myapp
cf events myapp
cf logs myapp --recent
```

---

# <span style="color: #8FF541;">DELIVERED</span>

```nohighlight
As a CF operator
I can provision a new CF user
So that user can `cf push` their app
```

---

## [ Further reading ](#/3)

* CF_TRACE=true cf ...
* cf curl
   * https://blog.starkandwayne.com/2015/03/20/admin-scripting-your-way-around-cloud-foundry/
   * http://apidocs.cloudfoundry.org/
* cf buildpacks
   * https://docs.cloudfoundry.org/adminguide/buildpacks.html
* CF CLI plugins
   * https://docs.cloudfoundry.org/devguide/installcf/use-cli-plugins.html


---

<section style="position: absolute; bottom:0; font-size: 0.5em; text-align: center">
This content is copyright of CloudCredo.<br>
© CloudCredo 2015. All rights reserved.
</section>
