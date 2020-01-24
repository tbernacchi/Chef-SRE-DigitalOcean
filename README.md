# lnx_sre
Instructions to use this project.

## Requirements
- Chef-server;
- CentOS 7.6 
- Ruby 2.4.0 or higher;
- selinux disable;

## How-to 
This directory contains the chef-repo where cookbooks are stored and a simple script to register the node on chef-server.

- Copy the first_boot_chef.sh to the server;
```
./first_boot_chef.sh
```

After the execution it's finished the server it's registered on Chef-server with nodejs installed.

- Add the bootstrap_lnx recipe:
```
knife node run_list add <node> "recipe[bootstrap_lnx]"
```

- Chef-client on node
```
chef-client
```
