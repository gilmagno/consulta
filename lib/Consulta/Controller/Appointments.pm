package Consulta::Controller::Appointments;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

sub auto :Private {
    my ($self, $c) = @_;

    $c->detach('/unauthorized') if $c->check_user_roles('Paciente');
    return 1;
}

sub base :Chained('/') PathPart('agenda') CaptureArgs(0) {
    my ($self, $c) = @_;

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

    my $month;
    my $year;

    if ($c->req->param('f')) {
        ($year)  = $c->req->param('f') =~ /^(\d+)-/;
        ($month) = $c->req->param('f') =~ /-(\d+)$/;
    }
    else {
        my $date_now = DateTime->now;    $c->log->debug($date_now);
        $year        = $date_now->year;
        $month       = $date_now->strftime('%m');
    }

    my $date_start = DateTime->new(year   => $year,
                                   month  => $month,
                                   day    => 1,
                                   hour   => 0,
                                   minute => 0,
                                   second => 0);

    my $date_end   = DateTime->last_day_of_month(year   => $year,
                                                 month  => $month,
                                                 hour   => 23,
                                                 minute => 59,
                                                 second => 59);

    my $where = { date_time => { '>' => $date_start->datetime,
                                 '<' =>   $date_end->datetime  }  };


    my $attrs = { prefetch => [qw/doctor patient/],
                  order_by => { -asc => 'date_time' } };

    my @appointments_list = $c->stash->{appointments_rs}->search($where, $attrs);

    my @days;
    for my $day ($date_start->day .. $date_end->day) {
        push @days, DateTime->new(year  => $date_start->year,
                                  month => $date_start->month,
                                  day   => $day);
    }

    my %appointments;
    for my $appointment_item (@appointments_list) {
        push @{ $appointments{ $appointment_item->date_time->ymd('-') } }, $appointment_item;
    }

    $c->stash(appointments      => \%appointments,
              days              => \@days,
              year              => $year,
              month             => $month,
              year_month_before => $date_start->subtract(months => 1)->strftime('%Y-%m'),
              year_month_after  => $date_start->add     (months => 2)->strftime('%Y-%m')  );
}

sub details :Chained('object') PathPart('') Args(0) {
    my ($self, $c) = @_;
}

sub create :Chained('base') PathPart('criar') Args(0) {
    my ($self, $c) = @_;

    my $form = HTML::FormFu->new({ load_config_file => 'root/forms/appointments/form.pl' });
    $form->process($c->req->params);

    if ($form->submitted_and_valid) {
        my $appointment = $c->model('DB::Appointment')->new_result({});

        # set $register_id = $c->user->id in $form

        $form->model->update( $appointment );

        $c->flash->{success_msg} = 'Agendamento criado.';
        $c->res->redirect( $c->uri_for_action( '/appointments/details', [$appointment->id] ) );
    }

    $c->stash(form => $form);
}

sub edit :Chained('object') PathPart('editar') Args(0) {}

sub delete :Chained('object') PathPart('deletar') Args(0) {}

__PACKAGE__->meta->make_immutable;

1;


__END__

