package Consulta::Schema::ResultSet::Appointment;
use base 'DBIx::Class::ResultSet';
use DateTime;

sub appointments_today {
    my ($self) = @_;

    my $date_now = DateTime->now;

    my $where = { 'me.date_time' => { '>' => $date_now->ymd('-') . ' 00:00:00',
                                      '<' => $date_now->ymd('-') . ' 23:59:59' } };
    my $attrs = { order_by => { -asc => 'me.date_time' } };

    my $appointments_rs = $self->search_rs($where, $attrs);

    return $appointments_rs->all;
}

1;
