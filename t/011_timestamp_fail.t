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

my $service = II::SSS->new(
    shared_key => '6c45f3c983aebe6cb9f185602d23ba3f3589ff6c'
);
isa_ok( $service, 'II::SSS' );

my $provider = $service->provider;
isa_ok( $provider, 'II::SSS::Provider' );

my $message = $provider->generate( data => { foo => 'bar' } );

is_deeply(
    [ sort keys %$message ],
    [qw[ data hmac timestamp ]],
    '... got the right set of keys'
);

like( $message->{timestamp}, qr/^\d+$/, '... the timestamp is a number' );
like( $message->{hmac}, qr/^[0-9a-f]{40}$/, '... the hmac looks like a hexdigest' );
is( $message->{data}, '{"foo":"bar"}', '... the data is the expected JSON');

my $consumer = $service->consumer(
    timestamp_tolerance => DateTime::Duration->new( seconds => 1 )
);
isa_ok( $consumer, 'II::SSS::Consumer' );

diag "Sleep for 2 seconds so the token can expire";
sleep(2);

throws_ok {
    $consumer->verify( %$message );
} qr/II::SSS::Error::TokenExpired/, '... message fails to verify correctly';


done_testing;



