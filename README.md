# lnx_sre
Instructions to use this project.

## Requirements
- Chef-server;
- knife (Chef-client);
- CentOS 7.6 

## How-to 
This directory contains the chef-repo where cookbooks are stored and a simple script to register the node on chef-server.

- Copy the first_boot_chef.sh to the server;
```
./first_boot_chef.sh
```

After the execution it's finished the server it's registered on Chef-server with nodejs installed.

- Upload cookbooks:
<pre>knife cookbook upload nodejs --force
knife cookbook upload bootstrap_lnx
</pre>

- Add the bootstrap_lnx recipe:
```
knife node run_list add <node> "recipe[bootstrap_lnx]"
```

- Chef-client on node
```
chef-client
```
