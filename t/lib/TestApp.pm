package TestApp;
use Moose;

use Catalyst; # '-Debug';

TestApp->config( name => 'TestApp' );
TestApp->setup;

1;
