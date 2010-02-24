package CatalystX::Controller::II::SSS;
use Moose;

use II::SSS;

our $VERSION   = '0.01';
our $AUTHORITY = 'cpan:STEVAN';

BEGIN { extends 'Catalyst::Controller' }

has 'service' => (
    is      => 'ro',
    isa     => 'II::SSS',
    lazy    => 1,
    default => sub {
        my $self = shift;
        II::SSS->new(
            shared_key => $self->config->{ shared_key }
        )
    },
);

sub provide : Local {
    my ($self, $c) = @_;
    $c->response->redirect(
        $self->generate_url_for_provider(
            $c, $self->service->provider
        )
    );
}

sub consume : Local {
    my ($self, $c) = @_;
    $c->response->redirect(
        $self->generate_url_for_consumer(
            $c, $self->service->consumer
        )
    );
}

sub generate_url_for_provider { die }
sub generate_url_for_consumer { die }

__PACKAGE__->meta->make_immutable;

no Moose; 1;

__END__

=pod

=head1 NAME

CatalystX::Controller::II::SSS - A Moosey solution to this problem

=head1 SYNOPSIS

  use CatalystX::Controller::II::SSS;

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
