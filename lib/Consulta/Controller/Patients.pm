package Consulta::Controller::Patients;
use Moose;
use namespace::autoclean;
use utf8;

BEGIN { extends 'Catalyst::Controller' }

sub base :Chained('/') PathPart('pacientes') CaptureArgs(0) {
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
        $c->flash->{error_msg} = 'Não foi possível acessar o paciente solicitado.';
        $c->res->redirect( $c->uri_for_action('/patients/index') );
        $c->detach('index');
    }

    $c->stash(user => $user);

    # Um paciente não pode ver dados de outro
    $c->detach('/unauthorized')
      if $c->check_user_roles('Paciente') and $c->user->id != $user->id;
}

sub index :Chained('base') PathPart('') Args(0) {
    my ($self, $c) = @_;

    $c->detach('/unauthorized') unless $c->check_user_ability('users_view_list');

    my $where;
    my $q;
    my $page ||= 1;

    if ($c->req->param('q')) {
        $q = $c->req->param('q');

        # TODO Tratar segurança
        $q =~ s/(<|>)//g; # Tira tags

        $where = { 'me.name' => { ilike => '%' . $q . '%' } };
    }

    if ($c->req->param('pg')) {
        $page = $c->req->param('pg');
    }

    my ($users, $pager) = $c->stash->{users_rs}->get_patients_paginated($page, $where);

    $c->stash(users => $users,
              pager => $pager,
              q     => $q);
}

sub details :Chained('object') PathPart('') Args(0) {
    my ($self, $c) = @_;

    my @consultations = $c->stash->{user}->consultations_patients(
        undef,
        { rows     => 5,
          order_by => [ { -desc => 'date' },
                        { -desc => 'id'   } ] }
    );

    my @prescriptions_glasses = $c->stash->{user}->prescriptions_glasses_patients(
        undef,
        { rows     => 5,
          order_by => [ { -desc => 'date' },
                        { -desc => 'id'   } ] }
    );

    $c->stash(consultations         => \@consultations,
              prescriptions_glasses => \@prescriptions_glasses);
}

sub create :Chained('base') PathPart('criar') Args(0) {
    my ($self, $c) = @_;

    $c->detach('/unauthorized') unless $c->check_user_ability('users_create');

    my $form = HTML::FormFu->new({ load_config_file => 'root/forms/patients/form.pl' });
    $form->process($c->req->params);

    if ($form->submitted_and_valid) {
        my $user = $c->model('DB::User')->new_result({});
        $form->model->update( $user );

        my $patient_role = $c->model('DB::Role')->find
          ({ name => 'Paciente' });

        $user->add_to_user_roles({ role_id => $patient_role->id });

        $c->flash->{success_msg} = 'Paciente criado.';
        $c->res->redirect( $c->uri_for_action( '/patients/details', [$user->id] ) );
    }

    $c->stash(form => $form);
}

sub edit :Chained('object') PathPart('editar') Args(0) {
    my ($self, $c) = @_;

    $c->detach('/unauthorized') unless $c->check_user_ability('users_edit');

    my $form = HTML::FormFu->new({ load_config_file => 'root/forms/patients/form.pl' });
    $form->process($c->req->params);

    if ($form->submitted_and_valid) {
        $form->model->update( $c->stash->{user} );
        $c->flash->{success_msg} = 'Paciente editado.';
        $c->res->redirect
          ( $c->uri_for_action( '/patients/details', [$c->stash->{user}->id] ) );
    }
    else {
        $form->model->default_values( $c->stash->{user} );
    }

    $c->stash(form => $form);
}

sub delete :Chained('object') PathPart('deletar') Args(0) {
    my ($self, $c) = @_;

    $c->detach('/unauthorized') unless $c->check_user_ability('users_delete');
}

sub password :Chained('object') PathPart('senha') Args(0) {
    my ($self, $c) = @_;

    $c->detach('/unauthorized') unless $c->check_user_ability('users_edit');

    my $form = HTML::FormFu->new
      ({ load_config_file => 'root/forms/patients/password.pl' });
    $form->stash->{schema} = $c->model('DB');
    $form->process($c->req->params);

    if ($form->submitted_and_valid) {
        $form->model->update( $c->stash->{user} );
        $c->flash->{success_msg} = 'Paciente editado.';
        $c->res->redirect
          ( $c->uri_for_action( '/patients/details', [$c->stash->{user}->id] ) );
    }
    else {
        $form->model->default_values( $c->stash->{user} );
    }


    $c->stash(form => $form);
}

__PACKAGE__->meta->make_immutable;

1;
