package Consulta::Controller::Appointments;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

sub base :Chained('/') PathPart('agenda') CaptureArgs(0) {
    my ($self, $c) = @_;

    $c->detach('/unauthorized') if $c->check_user_roles('Paciente');

    my $appointments_rs = $c->model('DB::Appointment');
    $c->stash(appointments_rs => $appointments_rs);
}

sub object :Chained('base') PathPart('') CaptureArgs(1) {
    my ($self, $c, $appointment_id) = @_;

    my $appointment;
    eval {
        $appointment = $c->stash->{appointments_rs}->find($appointment_id);
    };

    if ($@ or !$appointment) {
        $c->flash->{error_msg} = 'Não foi possível acessar o agendamento solicitado.';
        $c->res->redirect( $c->uri_for_action('/appointments') );
        $c->detach('index');
    }

    $c->stash(appointment => $appointment);
}

sub index :Chained('base') PathPart('') Args(0) {
    my ($self, $c) = @_;

    # TODO Limitar temporalmente de alguma forma.
    my @appointments = $c->stash->{appointments_rs}->search
      (undef, { order_by => { -asc => 'date_time' } });

    $c->stash(appointments => \@appointments);
}

sub create :Chained('base') PathPart('criar') Args(0) {}

sub edit :Chained('object') PathPart('editar') Args(0) {}

sub delete :Chained('object') PathPart('deletar') Args(0) {}

__PACKAGE__->meta->make_immutable;

1;
