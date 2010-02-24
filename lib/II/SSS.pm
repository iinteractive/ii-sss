package II::SSS;
use Moose;

use II::SSS::Consumer;
use II::SSS::Provider;

our $VERSION   = '0.01';
our $AUTHORITY = 'cpan:STEVAN';

has 'shared_key' => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
);

sub consumer {
    II::SSS::Consumer->new( key => (shift)->shared_key, @_ )
}

sub provider {
    II::SSS::Provider->new( key => (shift)->shared_key, @_ )
}

__PACKAGE__->meta->make_immutable;

no Moose; 1;

__END__

=pod

=head1 NAME

II:SSS - A shared session service

=head1 SYNOPSIS

  use II:SSS;

=head1 DESCRIPTION

The idea of this module is to provide an easy and secure
way in which authenticated sessions can be shared between
trusted applications.

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
