package Consulta::Schema::ResultSet::User;
use base 'DBIx::Class::ResultSet';
use utf8;

=head1 METHODS

=head2 pacients_paginated

Faz query e retorna apenas users que são pacientes.

Recebe opcionalmente $page, \%where, \%attrs.
Retorna lista $results, $pager.

=cut

sub get_patients_paginated {
    my ($self, $page, $where, $attrs) = @_;

    return $self->_get_users_from_role_paginated('Paciente', $page, $where, $attrs);
}

=head2 doctors_paginated

Faz query e retorna apenas users que são médicos.

Recebe opcionalmente $page, \%where, \%attrs.
Retorna lista $results, $pager.

=cut

#sub get_doctors_paginated {
#    my ($self, $page, $where, $attrs) = @_;
#
#    return $self->_get_users_from_role_paginated('Médico', $page, $where, $attrs);
#}

=head2 doctors_paginated

Faz query e retorna apenas users que são de determinada role.

Recebe opcionalmente $page, \%where, \%attrs.
Retorna lista $results, $pager.

=cut

sub _get_users_from_role_paginated {
    my ($self, $role, $page, $where, $attrs) = @_;

    $where->{'role.name'} = $role;

    my $attrs = { join     => { user_roles => role      },
                  order_by => { -asc        => 'me.name' },
                  page     => $page };

    my $users_rs = $self->search_rs($where, $attrs);
    my $pager    = $users_rs->pager;

    return [$users_rs->all], $pager;
}

sub get_doctors {
    my ($self) = @_;

    my $where = { 'role.name' => 'Médico' };
    my $attrs = { join     => { user_roles  =>  role  },
                  order_by => { -asc        => 'me.name' }   };

    my $users_rs = $self->search_rs($where, $attrs);

    return $users_rs->all;
}

sub get_doctors_as_select_options {
    my ($self) = @_;

    my @doctors = $self->get_doctors;
    my @doctors_options = map { [ $_->id, $_->name ] } @doctors;

    return \@doctors_options;
}

1;
