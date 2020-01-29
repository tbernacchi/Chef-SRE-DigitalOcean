#!/bin/bash
# Register the host on Chef-server.
# You should replace the lnx_teste.pem with your own from your chef_server as well the url_chef_server on cliente.rb.
#Disable selinux
echo 0 > /sys/fs/selinux/enforce

install_ruby () {  
curl -sSL https://get.rvm.io | bash -s stable --ruby
curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -
curl -sSL https://rvm.io/pkuczynski.asc | gpg2 --import -
rvm install 2.4.0 2> /dev/null
rvm use 2.4.0 --default 2> /dev/null
} 
install_ruby 

export HOME=/root
IP="$(hostname -I)"
FQDN="$(hostname -f)"
HOSTNAME="$(hostname | awk -F. '{ print $1 }')"
CHEF_VERSION="chef-13.10.0-1.el7.x86_64.rpm"

#hostname
if [ -f "/etc/hostname" ]; then
  echo "$FQDN" > /etc/hostname && hostnamectl set-hostname "$FQDN"
fi

echo "NETWORKING=yes
NOZEROCONF=yes
NETWORKING_IPV6=no
IPV6INIT=no
HOSTNAME=${FQDN}" > /etc/sysconfig/network

#/etc/hosts
echo "127.0.0.1 ${FQDN} ${HOSTNAME} localhost.localdomain localhost" > /etc/hosts
echo "${IP} ${FQDN} ${HOSTNAME}" >> /etc/hosts

#Install Chef
yum clean all
yum install wget -y
yum makecache fast
wget -q https://packages.chef.io/files/stable/chef/13.10.0/el/7/"${CHEF_VERSION}"

cat <<EOF > /root/lnx_teste.pem
-----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEA5301DwVBX+4/YuVs0Q2PtsDXUJ1mvFQWhtWDsNr+f0mVXoTp
hFRSrTr4cnRf67elfdGw8/p7OCL84NLki5VpeJ/uyRpc3UUozRB27ifaXFe4mPOP
2cGC61f3/o4ZF+r4Qdq4Hjq7JrAmssNIGRXrRXdqswUrjpyuN3m2ZQDVxiYmgljT
+YCANScFpXMAWe6cVVZjd6w48r3ccptlKHGKGG2808cyTahEU5QfndE+Fp2fjrc/
f79nm2/RfsChqkvCJUZjtZSKBfvGuQhFzsqT95wefjCFy99kOkI6KEM4ulTdlVKn
mOhKw9/DYOKzlIz5pccDvjZxbf7LmD6RmNRtcwIDAQABAoIBAQDdHXP5DQQNJf3V
8V+nsFR+NGV202K2sXty/6/y1rwRya+rwTls9T6jyZhXe2HEPn8NV6a25aOdU45J
EijMS8ObPOlRnqTllpIKjpeLlPW3DvN85emaDoWHV1fDBuhhOEg6XzlPZrotkkTk
rDPKAm3gxNhed6nLZ03iH5hhkhKgWS95Wm1odvxfrL3GmHN6D4E6+HXJfW3nI8ki
ZCamfuoCMakCeYclCWr+FMMRD37Bqr5coHcd29e1/3jE3m4fHxda7EqMny+HcHwO
hdxUizC2Lb+TS6OFKXGcYNs8LSGWYLaqyg0KKT8o4Ti+8B9cvgGo0dN0W9idArjH
2vP7lT8BAoGBAPg6SHIY8lX1jYYOaa78eRslAx3CU3KQype5MgeIpqhHPBkX6fxJ
IsyRTCeK8uWAd+w4BdOcMwvkYIe7heUdRvunM6RYfITCJA3ToaoRMIK5toRdJPRj
RroXT4wE790ZDaMUVM1fwem3E7Dv7zh01JkYzoowBh/9B4DSSW7f1ynxAoGBAO68
wMHrIyHg8trzf4LSJL+7IYI5cH8LNtM9uYwq8TCoSMoG50fi4ypSsGSI9int4m/h
rIgQW0typ5WlKsJRnlDv1+cC48G2em+E2Vz7b7Y4os5OaJ29NiFLu/syC9FkWi7X
wCbCuevak7qhugGp20IyAb+jyK/0C0H2VCiuz0mjAoGBAJYOlbDzx7uTH6TEnbq8
wXFZZJLe4JdHVFF4EPhg8W6U8Y2x2S87/x9vTnwxETkP+m8ARvVvXaR4wKoNAJpK
opiKsTtOiqeuvSDmqLoofgzou580t5xNT3o7kUjxyxb7iDTnm4QzuQPSOsMhqJmW
dta+Gk2LToiT669CcEXoZyfhAoGAb2olZxqOXcw2alpDAtGBlv0FCVo3FwMrxe/D
fRe5UeTne2k3XIQVUfYfHfwRLcY369DdDO7dPFu4vAzF5MPkZ49XKhdeJVQ81Xih
XFR3cQoDaNaM2jioX2eRxgw4GbOEpuHHag9sZxat5OZ/ATG9AqqFyGLuULdK3bDQ
29+hG5MCgYB5ztw5s16S2oBmn9Up/e/u6KzmpoGjWAXMWCsvMUQwI2cjdvS7OVG9
hj0rYATKl92aQOLnddn7hbSxXmyVbX1N3HNRC1jeztq7sSr7f/feEIeQE69WBJyq
WNUg0v9JWwWfVEwzQOkZ77zHsvA/1p6qbjBjnTAmvZJ/TZiE1YdKQw==
-----END RSA PRIVATE KEY-----
EOF
rpm -i "${CHEF_VERSION}" --quiet

#Client.rb
mkdir -p /etc/chef
rm -f /etc/chef/client.*
 
touch /etc/chef/client.rb

cat <<EOF > /etc/chef/client.rb
# Server definitions
chef_server_url  "https://174.138.44.254/organizations/lnx_teste"
validation_key "/etc/chef/lnx_teste.pem"
validation_client_name "lnx_teste-validator" 
node_name "${FQDN}"
ssl_verify_mode    :verify_none
file_backup_path   "/var/lib/chef"
file_cache_path    "/var/cache/chef"
pid_file           "/var/run/chef/client.pid"
cache_options({ :path => "/var/cache/chef/checksums", :skip_expires => true})
signing_ca_user "chef"
EOF
  
#Copy validation.pem
/bin/cp -pr /root/lnx_teste.pem /etc/chef/lnx_teste.pem

chmod 600 /etc/chef/*.pem

#Coloca na run_list
echo "{\"run_list\":[\"recipe[nodejs]\"]}" > /etc/chef/first-boot.json

#Chef-client bootstrap
/usr/bin/chef-client -j /etc/chef/first-boot.json
