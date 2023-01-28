#!/bin/bash
echo "Uninstalling the PHP Email WHM Plugins..."

echo -n "Removing phpemail.jpg from the /usr/local/cpanel/whostmgr/docroot/addon_plugins/ directory "
rm -f /usr/local/cpanel/whostmgr/docroot/addon_plugins/phpemail.jpg
echo "Done"

echo -n "Removing phpemail.php from the /usr/local/cpanel/whostmgr/docroot/phpemail/ directory "
rm -f /usr/local/cpanel/whostmgr/docroot/phpemail/phpemail.php
echo "Done"

echo -n "Removing the phpemail directory from the /usr/local/cpanel/whostmgr/docroot/ directory "
rmdir /usr/local/cpanel/whostmgr/docroot/phpemail
echo "Done"

echo -n "Removing the phpemail.tar.gz file from the /root/ directory "
rm -f /root/whmphpemail.tar.gz
echo "Done"

echo -n "Removing the phpemail_install.pl file from the /root/ directory "
rm -f /root/phpemail_install.pl
echo "Done"

echo -n "Removing the phpemail.conf file from the /root/ directory "
rm -f /root/phpemail.conf
echo "Done"

echo -n "Unregistering the appconfig... "
/usr/local/cpanel/bin/unregister_appconfig /var/cpanel/apps/phpemail.conf
echo "Done"


echo "PHP Email WHM Plugin has been successfully removed."
rm -f /root/phpemail_uninstall.sh
