#!/usr/bin/perl

use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/lib";

use Test::More;

BEGIN {
    eval "use Catalyst;";
    plan skip_all => "Catalyst is required for this test" if $@;
}

use Catalyst::Test 'TestApp';

{
    my $provider_request = HTTP::Request->new(
        GET => 'http://localhost:3000/sss/provide?url=http://localhost:3000/sss/consume'
    );

    ok(my $provider_response = request($provider_request), '... got a response from the request');
    is($provider_response->code, 302, '.. response code is 302');

    my $consumer_request = HTTP::Request->new(
        GET => $provider_response->header('location')
    );

    ok(my $consumer_response = request($consumer_request), '... got a response from the request');
    is($consumer_response->code, 302, '.. response code is 302');

    my $passed_request = HTTP::Request->new(
        GET => $consumer_response->header('location')
    );

    ok(my $passed_response = request($passed_request), '... got a response from the request');
    ok($passed_response->is_success, '... response is successful');
    is($passed_response->code, 200, '.. response code is 200');
    is($passed_response->content, 'Successful', '... got the content we expected');
}



done_testing;

