package Consulta::Controller::Patients::PrescriptionsMedicines;
use Moose;
use namespace::autoclean;
use utf8;

BEGIN { extends 'Catalyst::Controller' }

sub base :Chained('/patients/object') PathPart('receituarios-medicamentos') CaptureArgs(0) {
    my ($self, $c) = @_;

    $c->stash(prescriptions_rs => $c->model('DB::PrescriptionsMedicine'));
}

sub object :Chained('base') PathPart('') CaptureArgs(1) {
    my ($self, $c, $prescription_id) = @_;

    my $prescription;
    eval {
        $prescription = $c->stash->{prescriptions_rs}->find($prescription_id);
    };

    if ($@ or !$prescription) {
        $c->flash->{error_msg} = 'Não foi possível acessar o receituário solicitado.';
        $c->res->redirect(
            $c->uri_for_action( '/patients/prescriptionsmedicines/index', [$c->stash->{user}->id] )
        );
        $c->detach('index');
    }

    $c->stash(prescription => $prescription);
}

# soh listar receituarios do medico logado, se medico.  se atendente ou
# admin listar tds as consultas
sub index :Chained('base') PathPart('') Args(0) {
    my ($self, $c) = @_;

    my @prescriptions = $c->stash->{user}->prescriptions_medicines_patients
      (undef, { order_by => [ { -desc => 'date' }, { -desc => 'id' } ] });

    $c->stash(prescriptions => \@prescriptions);
}

sub details :Chained('object') PathPart('') Args(0) {
    my ($self, $c) = @_;

    #$c->detach('/unauthorized') unless $c->check_user_ability('consultations_details');
}

sub create :Chained('base') PathPart('criar') Args(0) {
    my ($self, $c) = @_;

    #$c->detach('/unauthorized') unless $c->check_user_ability('consultations_create');

    my $form = HTML::FormFu->new({ load_config_file => 'root/forms/patients/prescriptionsmedicines/form.pl' });

    $form->get_element({ name => 'medicine_id' })->options
      ($c->model('DB::Medicine')->get_medicines_as_select_options);
    $form->process($c->req->params);

    if ($form->submitted_and_valid) {
        my $prescription = $c->stash->{prescriptions_rs}->new_result({});
        $form->model->update( $prescription );

        # TODO Transação?
        $prescription->doctor_id($c->user->id);
        $prescription->patient_id($c->stash->{user}->id);
        $prescription->update;

        $c->flash->{success_msg} = 'Receituário de Medicamento criado.';
        $c->res->redirect( $c->uri_for_action(
            '/patients/prescriptionsmedicines/details', [$c->stash->{user}->id, $prescription->id]
        ) );
    }

    $form->default_values({ date => DateTime->now });

    $c->stash(form => $form);
}

sub edit :Chained('object') PathPart('editar') Args(0) {
    my ($self, $c) = @_;

    my $form = HTML::FormFu->new({ load_config_file => 'root/forms/patients/prescriptionsmedicines/form.pl' });
    $form->get_element({ name => 'medicine_id' })->options
      ($c->model('DB::Medicine')->get_medicines_as_select_options);
    $form->process($c->req->params);

    if ($form->submitted_and_valid) {
        my $prescription = $c->stash->{prescription};
        $form->model->update( $prescription );

        $c->flash->{success_msg} = 'Receituário de Medicamento editado.';
        $c->res->redirect( $c->uri_for_action(
            '/patients/prescriptionsmedicines/details', [$c->stash->{user}->id, $prescription->id]
        ) );
    }
    else {
        $form->model->default_values( $c->stash->{prescription} );
    }

    $c->stash(form => $form);
}

sub _populate_form_medicines {
    my ($self, $c, $form) = @_;


}

__PACKAGE__->meta->make_immutable;

1;
