package Consulta::Controller::Root;
use Moose;
use namespace::autoclean;
use utf8;
BEGIN { extends 'Catalyst::Controller' }

# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
__PACKAGE__->config(namespace => '');

=for

sub auto :Private {
    my ($self, $c) = @_;

    if ($c->action eq $c->controller('Root')->action_for('login') ||
          $c->action eq $c->controller('Root')->action_for('logout')) {
        return 1;
    }
    elsif ($c->user_exists) {
        if ($c->check_user_roles('Super Admin')) {
        }
        elsif ($c->check_user_roles('Admin')) {
        }
        elsif ($c->check_user_roles('Médico')) {
        }
        elsif ($c->check_user_roles('Paciente')) {
            $c->log->debug($c->action);
            if ($c->action =~ /^patients\// && $c->req->captures->[0] == $c->user->id) {
                $c->log->debug( $c->req->captures->[0] );
                $c->log->debug( $c->user->id );
                return 1;
            }
            else {
                $c->res->redirect($c->uri_for_action('/patients/details', [$c->user->id]));
                return 0;
            }

            #$c->log->debug(Dumper $c->req->captures);
            #$c->res->redirect($c->uri_for_action('/patients/details', [$c->user->id]));
            #return 1;
        }

        return 1;
    }

    $c->res->redirect('/entrar');
    return 0;
}

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    $c->log->debug(' Root::index ');
}

=for

sub login :Path('/entrar') Args(0) {
    my ( $self, $c ) = @_;

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

sub logout :Path('/sair') Args(0) {
    my ( $self, $c ) = @_;
    $c->logout;
    $c->res->redirect('/');
}

=cut

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
