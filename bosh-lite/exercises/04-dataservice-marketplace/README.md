## [ 04 - dataservice-marketplace ](#/1)

```nohighlight
As a CF operator
I can add a Redis dataservice to my CF platform
So that my users's apps can store state
```


<section style="position: absolute; bottom:0; font-size: 0.5em; text-align: center">
This content is copyright of CloudCredo.<br>
© CloudCredo 2015. All rights reserved.
</section>

---

## [ Data service marketplace ](#/1)

* CF runs stateless apps - where does the data go?
* Many BOSH releases for data services - see bosh.io

```bash
cd ~/exercises/04-dataservice-marketplace
bosh upload release cf-redis-release-407.tgz
bosh deployment cf-redis-deployment.yml
bosh -n deploy
```

---

## [ Service brokers ](#/2)

* Register data service with CF runtime
* Provision service
* Provide connection credentials

<div style="text-align:center"><img src="v2services-new.png" height="400"></div>

---

## [ BOSH errands ](#/2)

* BOSH jobs can be long running (default), or run once (errands)
* Many releases encapsulate setup scripts in an errand

```bash
bosh errands
bosh run errand broker-registrar
cf marketplace
```

---

## [ Bind service to app ](#/3)

* Create 

```bash
cf create-service redis shared-vm myapp-redis
```

* Bind

```nohighlight
cf bind-service myapp myapp-redis
cf restart myapp
```

* Connection details available in app ENV

```bash
curl -s myapp.10.244.0.34.xip.io # | jq '.["VCAP_SERVICES"]|fromjson'
```

---

## [ Security Groups ](#/4)

* Security Groups restrict outbound network access

```bash
curl -X PUT myapp.10.244.0.34.xip.io/foo -d 'data=bar' # Error?

cf logs myapp --recent # Cannot access redis
```

* Security Groups are applied to apps in a space

```bash
cat access_to_redis.json

cf create-security-group access_to_redis ./access_to_redis.json
cf bind-security-group access_to_redis platform-ops development
cf restage myapp

curl -X PUT myapp.10.244.0.34.xip.io/foo -d 'data=bar'
curl myapp.10.244.0.34.xip.io/foo
```

---

# <span style="color: #8FF541;">DELIVERED</span>

```nohighlight
As a CF operator
I can add a Redis dataservice to my CF platform
So that my users's apps can store state
```

---

## [ Further reading ](#/3)

* BOSH deployable data services
  * bosh.io/releases
* Manually provisioned data services
  * https://docs.cloudfoundry.org/devguide/services/user-provided.html

---

<section style="position: absolute; bottom:0; font-size: 0.5em; text-align: center">
This content is copyright of CloudCredo.<br>
© CloudCredo 2015. All rights reserved.
</section>


