package Consulta::Controller::Patients::Consultations;
use Moose;
use namespace::autoclean;
use utf8;

BEGIN { extends 'Catalyst::Controller' }

sub base :Chained('/patients/object') PathPart('consultas') CaptureArgs(0) {
    my ($self, $c) = @_;

    $c->stash(consultations_rs => $c->model('DB::Consultation'));
}

sub object :Chained('base') PathPart('') CaptureArgs(1) {
    my ($self, $c, $consultation_id) = @_;

    my $consultation;
    eval {
        $consultation = $c->stash->{consultations_rs}->find($consultation_id);
    };

    if ($@ or !$consultation) {
        $c->flash->{error_msg} = 'Não foi possível acessar a consulta solicitada.';
        $c->res->redirect(
            $c->uri_for_action( '/patients/consultations/index', [$c->stash->{user}->id] )
        );
        $c->detach('index');
    }

    $c->stash(consultation => $consultation);
}

# soh listar consultas do medico logado, se medico.  se atendente ou
# admin listar tds as consultas, mas soh mostrar na interface
# informacoes de 'dia' e 'medico'; nao mostrar mais q issso.

sub index :Chained('base') PathPart('') Args(0) {
    my ($self, $c) = @_;

    my @consultations = $c->stash->{user}->consultations_patients(undef, { order_by => { -desc => 'date' } });

    $c->stash(consultations => \@consultations);
}

sub details :Chained('object') PathPart('') Args(0) {
    my ($self, $c) = @_;

    $c->detach('/unauthorized') unless $c->check_user_ability('consultations_details');
}

sub create :Chained('base') PathPart('criar') Args(0) {
    my ($self, $c) = @_;

    $c->detach('/unauthorized') unless $c->check_user_ability('consultations_create');

    my $form = HTML::FormFu->new({ load_config_file => 'root/forms/patients/consultations/form.pl' });
    $form->process($c->req->params);

    if ($form->submitted_and_valid) {
        my $consultation = $c->stash->{consultations_rs}->new_result({});
        $form->model->update( $consultation );

        # TODO Transação?
        my $logged_user = $c->stash->{users_rs}->find(3); # TODO
        $consultation->register_id($logged_user->id); # TODO
        $consultation->patient_id($c->stash->{user}->id);
        $consultation->update;

        $c->flash->{success_msg} = 'Consulta criada.';
        $c->res->redirect( $c->uri_for_action(
            '/patients/consultations/details', [$c->stash->{user}->id, $consultation->id]
        ) );
    }

    $c->stash(form => $form);
}

sub edit :Chained('object') PathPart('editar') Args(0) {
    my ($self, $c) = @_;

    my $form = HTML::FormFu->new({ load_config_file => 'root/forms/patients/consultations/form.pl' });
    $form->process($c->req->params);

    if ($form->submitted_and_valid) {
        my $consultation = $c->stash->{consultation};
        $form->model->update( $consultation );

        $c->flash->{success_msg} = 'Consulta editada.';
        $c->res->redirect( $c->uri_for_action(
            '/patients/consultations/details', [$c->stash->{user}->id, $consultation->id]
        ) );
    }
    else {
        $form->model->default_values( $c->stash->{consultation} );
    }

    $c->stash(form => $form);
}

__PACKAGE__->meta->make_immutable;

1;
