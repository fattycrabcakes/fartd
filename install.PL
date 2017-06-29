#!/usr/bin/perl

use Modern::Perl;
use File::Util;
use File::Copy;
my $fu = File::Util->new();
foreach my $dir (qw(/etc/fartd/)) {
	$fu->make_dir($dir=> oct(755) => {if_not_exists=>1});
}

system("useradd -d /usr/share/fartd --user-group -s /usr/sbin/nologin fartd");

if (!-f "/etc/fartd/fartd.conf") {
	copy("conf/fartd.conf","/etc/fartd/");
}
copy("system/fartd.service","/etc/systemd/system");

foreach my $file (glob("share/*.*")) {
	copy($file,"/usr/share/fartd");
}

if (-f '/etc/fartd/fartd.conf') {
	qx('systemctl daemon-reload');
	qx('systemctl enable fartd');
}
system('systemctl start fartd');




