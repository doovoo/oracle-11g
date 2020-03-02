#!/usr/bin/env bash

set -e
source /assets/colorecho

users () {

	echo "Configuring users"
	groupadd -g 200 oinstall
	groupadd -g 201 dba
	useradd -u 440 -g oinstall -G dba -d /opt/oracle oracle
	echo "oracle:install" | chpasswd
	echo "root:install" | chpasswd
	sed -i "s/pam_namespace.so/pam_namespace.so\nsession    required     pam_limits.so/g" /etc/pam.d/login
	mkdir -p -m 755 /opt/oracle/app
	mkdir -p -m 755 /opt/oracle/oraInventory
	mkdir -p -m 755 /opt/oracle/dpdump
	chown -R oracle:oinstall /opt/oracle
	cat /assets/profile >> ~oracle/.bash_profile
	cat /assets/profile >> ~oracle/.bashrc

}

users

if [ ! -d "/opt/oracle/app/product/11.2.0/dbhome_1" ]; then
	echo_yellow "Database is not installed. Installing..."
	/assets/install.sh
fi

su oracle -c "/assets/entrypoint_oracle.sh"

