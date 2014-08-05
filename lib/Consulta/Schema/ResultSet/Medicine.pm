package Consulta::Schema::ResultSet::Medicine;
use base 'DBIx::Class::ResultSet';

sub get_medicines_as_select_options {
    my ($self) = @_;

    my @medicines = $self->search
      (undef, { order_by => { -asc => 'me.name' } });

    my @medicines_options = map { [ $_->id, $_->name ] } @medicines;

    return \@medicines_options;
}

1;
