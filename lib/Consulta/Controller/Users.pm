package Consulta::Controller::Users;
use Moose;
use namespace::autoclean;

use HTML::FormFu;

BEGIN { extends 'Catalyst::Controller' }

sub base :Chained('/') PathPart('usuarios') CaptureArgs(0) {
    my ($self, $c) = @_;

    $c->stash(users_rs => $c->model('DB::User'));
}

sub object :Chained('base') PathPart('') CaptureArgs(1) {
    my ($self, $c, $user_id) = @_;

    my $user;
    eval {
        $user = $c->stash->{users_rs}->find($user_id);
    };

    if ($@ or !$user) {
        $c->res->redirect( $c->uri_for_action( '/users/index') );
    }

    $c->stash(user => $user);
}

sub index :Chained('base') PathPart('') Args(0) {
    my ($self, $c) = @_;

    my $where;
    my $q;

    if ($c->req->param('q')) {
        $q = $c->req->param('q');

        # TODO Tratar segurança
        $q =~ s/(<|>)//g; # Tira tags

        $where = { name => { ilike => '%' . $q . '%' } };
    }

    my @users = $c->stash->{users_rs}->search($where, { order_by => { -asc => 'name' } });

    $c->stash(users => \@users, q => $q);
}

sub details :Chained('object') PathPart('') Args(0) {}

sub create :Chained('base') PathPart('criar') Args(0) {
    my ($self, $c) = @_;

    my $form = HTML::FormFu->new({ load_config_file => 'root/forms/users/form.pl' });
    $form->process($c->req->params);

    if ($form->submitted_and_valid) {
        my $user = $c->model('DB::User')->new_result({});
        $form->model->update( $user );
        $c->res->redirect( $c->uri_for_action( '/users/details', [$user->id] ) );
    }

    $c->stash(form => $form);
}

sub edit :Chained('object') PathPart('editar') Args(0) {
    my ($self, $c) = @_;

    my $form = HTML::FormFu->new({ load_config_file => 'root/forms/users/form.pl' });
    $form->process($c->req->params);

    if ($form->submitted_and_valid) {
        $form->model->update( $c->stash->{user} );
        $c->res->redirect( $c->uri_for_action( '/users/details', [$c->stash->{user}->id] ) );
    }
    else {
        $form->model->default_values( $c->stash->{user} );
    }

    $c->stash(form => $form);
}

sub delete :Chained('object') PathPart('deletar') Args(0) {}

__PACKAGE__->meta->make_immutable;

1;
