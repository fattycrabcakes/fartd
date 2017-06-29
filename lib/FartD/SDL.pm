package FartD::SDL;

use 5.022001;
use strict;
use warnings;
our $VERSION="0.1.0";

require XSLoader;


XSLoader::load('FartD::SDL', $VERSION);


1;
