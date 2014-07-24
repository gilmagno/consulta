package Consulta::Controller::Root;
use Moose;
use namespace::autoclean;
use utf8;
use HTML::FormFu;
use Data::Dumper;

BEGIN { extends 'Catalyst::Controller' }

# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
__PACKAGE__->config(namespace => '');

sub auto :Private {
    my ($self, $c) = @_;

    if ( $c->action eq $c->controller('Root')->action_for('login') ) {
        return 1;
    }
    elsif (!$c->user_exists) {
        $c->res->redirect($c->uri_for_action('/login'));
        return 0;
    }

    #$c->log->debug( $c->uri_for_action('/patients/details', [3]) );

    #$c->log->debug('Path: ' . $c->req->path );
    #$c->log->debug('Action: ' . $c->req->action );
    #$c->log->debug('Captures: ' . (Dumper $c->req->captures) );

    return 1;
}

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->detach('/unauthorized') if $c->check_user_roles('Paciente');
}

sub unauthorized :Local Args(0) {
    my ( $self, $c ) = @_;

    if ($c->check_user_roles('Paciente')) {
        $c->flash->{error_msg} = 'Não autorizado/a.';
        $c->res->redirect($c->uri_for_action('/patients/details', [$c->user->id]));
    }
}

sub login :Path('/entrar') Args(0) {
    my ( $self, $c ) = @_;

    if ($c->req->method eq 'POST') {
        my $credentials = { username => $c->req->param('username'),
                            password => $c->req->param('password') };
        if ($c->authenticate($credentials)) {
            $c->log->debug('authenticated: ' . $c->user->username);
            if ($c->check_user_roles('Paciente')) {
                $c->res->redirect($c->uri_for_action('/patients/details', [$c->user->id]));
            }
            else {
                $c->res->redirect('/');
            }
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
    $c->res->redirect('/entrar');
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

__END__

[info] *** Request 7 (0.003/s) [7754] [Wed Jul 23 14:32:17 2014] ***
[debug] Path is "/patients/consultations/details"
[debug] "GET" request for "pacientes/4/consultas/3" from "127.0.0.1"
[debug] Found sessionid "3497e613566441f7db9ac58baa2a0b6e287b9f65" in cookie
[debug] Restored session "3497e613566441f7db9ac58baa2a0b6e287b9f65"
[debug] http://localhost:3000/pacientes/3
[debug] Path: pacientes/4/consultas/3
[debug] Action: /patients/consultations/details
[debug] Captures: $VAR1 = [
          '4',
          '3'
        ];
