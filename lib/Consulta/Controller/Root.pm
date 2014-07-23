package Consulta::Controller::Root;
use Moose;
use namespace::autoclean;
use utf8;
BEGIN { extends 'Catalyst::Controller' }

# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
__PACKAGE__->config(namespace => '');

sub auto :Private {
    my ($self, $c) = @_;

    if ( $c->action eq $c->controller('Root')->action_for('login') ||
         $c->action eq $c->controller('Root')->action_for('logout')   ) {
        return 1;
    }
    elsif (!$c->user_exists) {
        $c->res->redirect($c->uri_for_action('/login'));
        return 0;
    }

    return 1;
}

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    $c->log->debug(' Root::index ');
}

sub login :Path('/entrar') Args(0) {
    my ( $self, $c ) = @_;

    #for (1..100_000_000_000) {
    #    $c->log->debug( 30*$_ );
    #}

    $c->log->debug('login action being run');
    if ($c->req->method eq 'POST') {
        my $credentials = { username => $c->req->param('username'),
                            password => $c->req->param('password') };
        if ($c->authenticate($credentials)) {
            $c->res->redirect('/');
        }
        else {
            $c->flash->{error_msg} = 'Não foi possível entrar.';
            $c->res->redirect('/entrar');
        }
    }
}

sub logout :Path('sair') Args(0) {
    my ( $self, $c ) = @_;
    $c->logout;
    $c->res->redirect('/');
}

=head2 default

Standard 404 error page

=cut

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {}

__PACKAGE__->meta->make_immutable;

1;
