use utf8;
package Consulta::Schema::Result::User;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';
__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp");
__PACKAGE__->table("users");
__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "users_id_seq",
  },
  "username",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "password",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "name",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "rg",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "cpf",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "address_state_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "address_city_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "address_street_etc",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "address_district",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "address_zip_code",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "phone",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "phone2",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "email",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "email2",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "created",
  { data_type => "timestamp with time zone", is_nullable => 1 },
  "updated",
  { data_type => "timestamp with time zone", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("users_username_key", ["username"]);
__PACKAGE__->belongs_to(
  "address_city",
  "Consulta::Schema::Result::City",
  { id => "address_city_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);
__PACKAGE__->belongs_to(
  "address_state",
  "Consulta::Schema::Result::State",
  { id => "address_state_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);
__PACKAGE__->has_many(
  "appointments_doctors",
  "Consulta::Schema::Result::Appointment",
  { "foreign.doctor_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->has_many(
  "appointments_patients",
  "Consulta::Schema::Result::Appointment",
  { "foreign.patient_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->has_many(
  "appointments_registers",
  "Consulta::Schema::Result::Appointment",
  { "foreign.register_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->has_many(
  "consultations_patients",
  "Consulta::Schema::Result::Consultation",
  { "foreign.patient_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->has_many(
  "consultations_registers",
  "Consulta::Schema::Result::Consultation",
  { "foreign.register_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->has_many(
  "prescriptions_glasses_doctors",
  "Consulta::Schema::Result::PrescriptionsGlass",
  { "foreign.doctor_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->has_many(
  "prescriptions_glasses_patients",
  "Consulta::Schema::Result::PrescriptionsGlass",
  { "foreign.patient_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->has_many(
  "prescriptions_medicines_doctors",
  "Consulta::Schema::Result::PrescriptionsMedicine",
  { "foreign.doctor_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->has_many(
  "prescriptions_medicines_patients",
  "Consulta::Schema::Result::PrescriptionsMedicine",
  { "foreign.patient_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->has_many(
  "user_roles",
  "Consulta::Schema::Result::UserRole",
  { "foreign.user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->many_to_many("roles", "user_roles", "role");


# Created by DBIx::Class::Schema::Loader v0.07035 @ 2014-08-05 14:37:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:/e9VxaqYFNgYuMFCjDnC0g

sub address {
    my $self = shift;

    my $street_etc = $self->address_street_etc;
    my $district   = $self->address_district;
    my $zip_code   = $self->address_zip_code;

    my $address;

    if ($street_etc) {
        $address .= $street_etc;
        if ($district) {
            $address .= '. Bairro: ' . $district;
        }
        if ($zip_code) {
            $address .= '. CEP: ' . $zip_code;
        }
    }
    elsif ($district) {
        $address .= 'Bairro: ' . $district;
        if ($zip_code) {
            $address .= '. CEP: ' . $zip_code;
        }
    }
    elsif ($zip_code) {
        $address .= 'CEP: ' . $zip_code;
    }

    return $address;
}

sub has_role {
    my ($self, $role) = @_;

    my @roles = $self->roles;

    return 1 if grep { $_ eq $role } @roles;
}

sub has_action {
    my ($self, $action) = @_;

    my @actions = $self->actions;

    return 1 if grep { $_ eq $action } @actions;
}

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
