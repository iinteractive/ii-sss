package II::SSS::Provider;
use Moose;
use MooseX::Params::Validate;

use DateTime;
use Digest::SHA1;
use Digest::HMAC;
use JSON;

our $VERSION   = '0.01';
our $AUTHORITY = 'cpan:STEVAN';

with 'II::SSS::Core';

sub generate {
    my ($self, $data) = validated_list(\@_,
        data => { isa => 'HashRef | ArrayRef' },

    );

    my $timestamp   = DateTime->now->epoch;
    my $packed_data = JSON->new->encode( $data );

    my $d = Digest::HMAC->new( $self->key, "Digest::SHA1" );
    $d->add( $timestamp );
    $d->add(" ");
    $d->add( $packed_data );

    return {
        timestamp => $timestamp,
        data      => $packed_data,
        hmac      => $d->hexdigest,
    }
}

__PACKAGE__->meta->make_immutable;

no Moose; 1;

__END__

=pod

=head1 NAME

II::SSS::Provider - A Moosey solution to this problem

=head1 SYNOPSIS

  use II::SSS::Provider;

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
