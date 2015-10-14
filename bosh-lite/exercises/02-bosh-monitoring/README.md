## [ 02 - BOSH monitoring ](#/1)

```nohighlight
As a CF operator
I can monitor and interact with my BOSH clusters
So that I can troubleshoot problems
```

<section style="position: absolute; bottom:0; font-size: 0.5em; text-align: center">
This content is copyright of CloudCredo.<br>
© CloudCredo 2015. All rights reserved.
</section>

---

## [ What is a CF cluster? ](#/1)

* Container orchestration for 12 factor apps / microservices
* Routing, scaling, health, audit, config, service bindings
* For self service app deploys

<div style="text-align:center"><img src="cf_architecture_block.png" height="300"></div>

```bash
bosh vms
```

---

## [ BOSH ssh ](#/2)

* SSH into doppler_z1/0 (choose temp sudo password)

```bash
vagrant ssh  # new terminal
bosh ssh --strict_host_key_checking no
```

* Structure and logs:

```bash
/var/vcap
 ├── bosh
 ├── bosh_ssh
 ├── data
 ├── jobs              <-- config
 ├── micro
 ├── micro_bosh
 ├── monit
 ├── packages          <-- binaries
 └── sys 
        └── log          <-- logs!

tail --lines=1 -f /var/vcap/sys/log/*/*
```

Note:

   vcap - CloudFoundry originated from the VMWare Cloud App
   c1oudc0w - used to be cashcow

---

## [ Monit ](#/2)

* Processes are run with Monit

```bash
sudo -i  # Enter the sudo password you chose
monit summary
```

* Monit resurrects failing processes

```bash
kill -9 $(cat /var/vcap/sys/run/doppler/doppler.pid)
watch monit summary
```

* Monit status is reported up to BOSH director

```bash
#in terminal 1
watch bosh vms
#in terminal 2
kill -9 $(cat /var/vcap/sys/run/doppler/doppler.pid)
```

---

## [ BOSH Health Monitor ](#/2)

* Original terminal

```bash
bosh vms
```

* BOSH agent sends heartbeats back to BOSH director

```bash
cd ~/exercises/02-cf-overview
./kill-VM
bosh vms
```

* BOSH can resurrect failed VM jobs (cattle, not pets)

```bash
bosh cloudcheck
```

---

# <span style="color: #8FF541;">DELIVERED</span>

```nohighlight
As a CF operator
I can monitor and interact with my BOSH clusters
So that I can troubleshoot problems
```

---

## [ Further reading ](#)

* BOSH Health Monitor plugins
  * BOSH can forward status data to external monitoring systems
  * http://bosh.io/docs/hm-config.html

---

<section style="position: absolute; bottom:0; font-size: 0.5em; text-align: center">
This content is copyright of CloudCredo.<br>
© CloudCredo 2015. All rights reserved.
</section>
