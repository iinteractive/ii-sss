package II::SSS::Core;
use Moose::Role;

use Digest::SHA1;
use Digest::HMAC;

our $VERSION   = '0.01';
our $AUTHORITY = 'cpan:STEVAN';

has 'key' => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
);

has 'json' => (
    is      => 'bare',
    isa     => 'JSON',
    lazy    => 1,
    default => sub { JSON->new },
    handles => {
        encode_data => 'encode',
        decode_data => 'decode',
    }
);

sub generate_digest {
    my ($self, $timestamp, $data) = @_;
    my $d = Digest::HMAC->new( $self->key, "Digest::SHA1" );
    $d->add( $timestamp );
    $d->add(" ");
    $d->add( $data );
    $d->hexdigest;
}

no Moose::Role; 1;

__END__

=pod

=head1 NAME

II::SSS::Core - A Moosey solution to this problem

=head1 SYNOPSIS

  use II::SSS::Core;

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
