package TestApp::Controller::SSS;
use Moose;

BEGIN { extends 'CatalystX::Controller::II::SSS' };

__PACKAGE__->config(
    shared_key => '6c45f3c983aebe6cb9f185602d23ba3f3589ff6c'
);

sub generate_url_for_provider {
    my ($self, $c, $provider) = @_;

    my $message = $provider->generate( data => { foo => 'bar' } );

    my $url = URI->new( $c->request->param('url') );
    $url->query(
        join "&" => map {
            $_ . '=' . $message->{ $_ }
        } keys %$message
    );

    $url;
}

sub generate_url_for_consumer {
    my ($self, $c, $consumer) = @_;

    my $result = $consumer->verify(
        hmac      => $c->request->param('hmac'),
        timestamp => $c->request->param('timestamp'),
        data      => $c->request->param('data'),
    );

    die unless ref $result eq 'HASH' && $result->{foo} eq 'bar';

    $c->uri_for('/sss/passed');
}

sub passed : Local {
    my ($self, $c) = @_;
    $c->response->body( 'Successful' );
}

1;