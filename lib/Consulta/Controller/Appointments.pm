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

sub index :Chained('base') PathPart('') Args(0) {
    my ($self, $c) = @_;

    my $date_now = DateTime->now;

    my $month;
    my $year;
    if ($c->req->param('f')) {
        ($year)  = $c->req->param('f') =~ /^(\d+)-/;
        ($month) = $c->req->param('f') =~ /-(\d+)$/;
    }
    else {
        $year  = $date_now->year;
        $month = $date_now->strftime('%m');
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

    if ($c->check_user_roles('Médico')) {
        $where->{doctor_id} = $c->user->id;
    }

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

    my @appointments_today = $c->stash->{appointments_rs}->appointments_today;

    $c->stash(date_now           => $date_now,
              appointments_today => \@appointments_today,

              days               => \@days,
              month              => $month,
              year               => $year,
              appointments       => \%appointments,

              year_month_before  => $date_start->subtract(months => 1)->strftime('%Y-%m'),
              year_month_after   => $date_start->add     (months => 2)->strftime('%Y-%m')  );
}

__PACKAGE__->meta->make_immutable;

1;
