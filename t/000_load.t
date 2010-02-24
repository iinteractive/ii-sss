#!/usr/bin/perl

use strict;
use warnings;

use Test::More;
use Test::Exception;
use Test::Moose;

BEGIN {
    use_ok('II::SSS');
    use_ok('II::SSS::Consumer');
    use_ok('II::SSS::Provider');
}



done_testing;