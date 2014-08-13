package Consulta::Controller::Patients::Appointments;
use Moose;
use namespace::autoclean;
use utf8;

BEGIN { extends 'Catalyst::Controller' }

sub auto :Private {
    my ($self, $c) = @_;

    $c->detach('/unauthorized') if $c->check_user_roles('Paciente');
    return 1;
}

sub base :Chained('/patients/object') PathPart('agendamentos') CaptureArgs(0) {
    my ($self, $c) = @_;

    my $appointments_rs = $c->model('DB::Appointment');
    $c->stash(appointments_rs => $appointments_rs);
}

sub object :Chained('base') PathPart('') CaptureArgs(1) {
    my ($self, $c, $appointment_id) = @_;

    my $appointment;
    my $where = { id => $appointment_id, patient_id => $c->stash->{user}->id };

    eval { $appointment = $c->stash->{appointments_rs}->find($where) };

    if ($@ or !$appointment) {
        $c->flash->{error_msg} = 'Não foi possível acessar o agendamento solicitado.';

        # TODO redirect e detach? :/ como fazer isso melhor (ou direito)?
        $c->res->redirect
          ( $c->uri_for_action('/patients/appointments/index', [$c->stash->{user}->id]) );
        $c->detach('index');
    }

    $c->stash(appointment => $appointment);
}

# TODO
sub index :Chained('base') PathPart('') Args(0) {
    my ($self, $c) = @_;

    my @appointments = $c->stash->{user}->appointments_patients(
        undef,
        { prefetch => ['patient', 'doctor'],
          order_by => { -desc => 'date_time' } }
    );

    $c->stash(appointments => \@appointments);
}

sub details :Chained('object') PathPart('') Args(0) {
    my ($self, $c) = @_;
}

sub create :Chained('base') PathPart('criar') Args(0) {
    my ($self, $c) = @_;

    my $form = HTML::FormFu->new
      ({ load_config_file => 'root/forms/patients/appointments/form.pl' });

    $form->get_element({ name => 'doctor_id' })->options
      ( $c->model('DB::User')->get_doctors_as_select_options );

    $form->process($c->req->params);

    if ($form->submitted_and_valid) {
        $form->add_valid('patient_id' => $c->stash->{user}->id);
        $form->add_valid('register_id' => $c->user->id);

        my $appointment = $c->model('DB::Appointment')->new_result({});
        $form->model->update( $appointment );

        $c->flash->{success_msg} = 'Agendamento criado.';
        $c->res->redirect(
            $c->uri_for_action(
                '/patients/appointments/details',
                [$c->stash->{user}->id, $appointment->id]
            )
        );
    }

    $c->stash(form => $form);
}

sub edit :Chained('object') PathPart('editar') Args(0) {
    my ($self, $c) = @_;

    my $appointment = $c->stash->{appointment};

    my $form = HTML::FormFu->new
      ({ load_config_file => 'root/forms/patients/appointments/form.pl' });

    $form->get_element({ name => 'doctor_id' })->options
      ( $c->model('DB::User')->get_doctors_as_select_options );

    $form->process($c->req->params);

    if ($form->submitted_and_valid) {
        $form->add_valid('register_id' => $c->user->id);

        $form->model->update( $appointment );

        $c->flash->{success_msg} = 'Agendamento editado.';
        $c->res->redirect(
            $c->uri_for_action(
                '/patients/appointments/details',
                [$c->stash->{user}->id, $appointment->id]
            )
        );
    }
    else {
        $form->model->default_values( $appointment );
    }

    $c->stash(form => $form);
}

sub delete :Chained('object') PathPart('deletar') Args(0) {
    my ($self, $c) = @_;

    $c->stash->{appointment}->delete;
    $c->flash->{success_msg} = 'Agendamento deletado';
    $c->res->redirect
      ( $c->uri_for_action( '/patients/appointments/index', [$c->stash->{user}->id]) );
}

__PACKAGE__->meta->make_immutable;

1;
