<h1 align="">Chef cookbook to deploy a node-js app 👋</h1>
<p>
</p>

> Chef cookbook to deploy a node-js app (linx SRE test)

![Chef](/.github/assets/img/chef-logo_orig.png)

<div align=>
	<img align="right" width="200px" src=/.github/assets/img/nodejs-logo.png>
</div> 

## Table of Contents

* **Chef**  
  * [Official Website](https://www.chef.io/)
  * [Official Docs](https://docs.chef.io/)
  * [Official Github](https://github.com/chef/chef)
* **Nodejs**
  * [Offical Website](https://nodejs.org/en/)
  * [Offical Docs](https://nodejs.org/en/docs/)
  * [Official Github](https://github.com/nodejs)

## Chef SRE DigitalOcean
I use this repo for a challenge, it's a cookbook to deploy a node.js app.

## Requirements
- Chef-server;
- knife;
- CentOS 7.6 

## How-to 
This directory contains the chef-repo where cookbooks are stored and a simple script to register the node on chef-server.

- Copy the first_boot_chef.sh to the server;
```
./first_boot_chef.sh
```

After the execution it's finished the server it's registered on Chef-server with nodejs installed. 

## Knife
We must copy the user and the validation key from the Chef-server to our workstation.

```
mkdir -p /Users/tadeu/.chef 
touch knife.rb
```
Your's knife.rb file must look like this:

```
node_name 'tadeu'
client_key '/Users/tadeu/.chef/tadeu.pem'
chef_server_url 'https://centos-s-2vcpu-4gb-nyc1-01/organizations/lnx_teste'
validation_key '/Users/tadeu/.chef/lnx_teste.pem'
cookbook_path '/Users/tadeu/lnx_sre/chef-repo/cookbooks/'
validation_client_name 'lnx_teste'
log_level :info
log_location STDOUT
node_name 'tadeu'
syntax_check_cache_path '/root/.chef/syntax_check_cache'
knife[:editor]="vim"
```
<pre>knife ssl fetch
knife ssl check
</pre> 

- To check:

```
knife client list 
```

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

For more information about Chef-server and Knife:<br/> 
http://www.tadeubernacchi.com.br/chef-workstation-chef-server-chef-client-via-bootstrap/

## Author

👤 **Tadeu Bernacchi**

* Website: http://www.tadeubernacchi.com.br/
* Twitter: [@tadeuuuuu](https://twitter.com/tadeuuuuu)
* Github: [@tbernacchi](https://github.com/tbernacchi)
* LinkedIn: [@tadeubernacchi](https://linkedin.com/in/tadeubernacchi)

## Show your support

Give a ⭐️ if this project helped you!

***
_This README was generated with ❤️ by [readme-md-generator](https://github.com/kefranabg/readme-md-generator)_
