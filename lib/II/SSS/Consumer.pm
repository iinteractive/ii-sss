package II::SSS::Consumer;
use Moose;
use MooseX::Params::Validate;

use DateTime;
use DateTime::Duration;
use Digest::SHA1;
use Digest::HMAC;
use JSON;

our $VERSION   = '0.01';
our $AUTHORITY = 'cpan:STEVAN';

use II::SSS::Error::HMACVerificationFail;
use II::SSS::Error::TokenExpired;

with 'II::SSS::Core';

has 'timestamp_tolerance' => (
    is      => 'ro',
    isa     => 'DateTime::Duration',
    lazy    => 1,
    default => sub { DateTime::Duration->new( seconds => 30 ) },
);

sub verify {
    my ($self, $timestamp, $data, $hmac) = validated_list(\@_,
        timestamp => { isa => 'Int' },
        data      => { isa => 'Str' },
        hmac      => { isa => 'Str' },
    );

    my $d = Digest::HMAC->new( $self->key, "Digest::SHA1" );
    $d->add( $timestamp );
    $d->add(" ");
    $d->add( $data );

    if ( $hmac eq $d->hexdigest ) {

        my $now   = DateTime->now;
        my $stamp = DateTime->from_epoch( epoch => $timestamp );
        my $diff  = $now - $stamp;

        unless ( DateTime::Duration->compare( $diff, $self->timestamp_tolerance ) <= 0 ) {
            die II::SSS::Error::TokenExpired->new;
        }

        return JSON->new->decode( $data );
    }
    else {
        die II::SSS::Error::HMACVerificationFail->new;
    }
}

__PACKAGE__->meta->make_immutable;

no Moose; 1;

__END__

=pod

=head1 NAME

II::SSS::Consumer - A Moosey solution to this problem

=head1 SYNOPSIS

  use II::SSS::Consumer;

=head1 DESCRIPTION

=head1 METHODS

=over 4

=item B<>

=back

=head1 BUGS

All complex software has bugs lurking in it, and this module is no
exception. If you find a bug please either email me, or add the bug
to cpan-RT.

=head1 AUTHOR

Stevan Little E<lt>stevan.little@iinteractive.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2010 Infinity Interactive, Inc.

L<http://www.iinteractive.com>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
