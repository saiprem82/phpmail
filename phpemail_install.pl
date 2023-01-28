#!/usr/local/cpanel/3rdparty/bin/perl

use Net::IP;
use IO::Uncompress::Gunzip qw(gunzip $GunzipError);
use File::Copy;
use Archive::Tar;
use Cpanel::SafeRun::Timed ();
use Cpanel::SafeRun::Errors();
use Term::ANSIColor qw(:constants);
$Term::ANSIColor::AUTORESET = 1;

system("clear");
print GREEN "Installing the PHPEmail WHM Plugin...\n";

# Create the directory for the plugin
print YELLOW "Creating /usr/local/cpanel/whostmgr/docroot/phpemail directory... ";
mkdir "/usr/local/cpanel/whostmgr/docroot/phpemail";
print CYAN " - Done\n";

# Obtain the plugin from Github
print YELLOW "Downloading whmphpemail.tar.gz... ";
Cpanel::SafeRun::Timed::timedsaferun( 4, 'wget', '-O', '/root/whmphpemail.tar.gz', '-o', '/dev/null', "https://raw.githubusercontent.com/saiprem82/phpmail/master/whmphpemail.tar.gz" );
print CYAN " - Done\n";

# Uncompress whmphpemail.tar.gz
print YELLOW "Extracting whmphpemail.tar.gz... ";
my $tar = Archive::Tar->new;
$tar->read("/root/whmphpemail.tar.gz");
$tar->extract();
print CYAN " - Done\n";

# Copy the phpemail.png (Icon) image file to /usr/local/cpanel/whostmgr/docroot/addon_plugins
print YELLOW "Copying phpemail.png to /usr/local/cpanel/whostmgr/docroot/addon_plugins... ";
move("/root/phpemail.png","/usr/local/cpanel/whostmgr/docroot/addon_plugins") or die "Copy failed: $!";
print CYAN " - Done\n";

# Copy the phpemail.php file to /usr/local/cpanel/whostmgr/docroot/phpemail
print YELLOW "Copying phpemail.php to /usr/local/cpanel/whostmgr/docroot/phpemail... ";
move("/root/phpemail.php","/usr/local/cpanel/whostmgr/docroot/phpemail") or die "Copy failed: $!";
print CYAN " - Done\n";

# Set execute permissions on the phpemail.php script
print YELLOW "Setting permissions on /usr/local/cpanel/whostmgr/docroot/phpemail/phpemail.php to 0755...";
chmod 0755, "/usr/local/cpanel/whostmgr/docroot/phpemail/phpemail.php";
print CYAN " - Done\n";

# Register the plugin
print YELLOW "Registering plugin...";
system( "/usr/local/cpanel/bin/register_appconfig /root/phpemail.conf" );

print GREEN "\nPHP Email WHM Plugin installed!\n";
unlink( "/root/whmphpemail.tar.gz" );
exit;