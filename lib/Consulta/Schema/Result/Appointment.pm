use utf8;
package Consulta::Schema::Result::Appointment;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';
__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp");
__PACKAGE__->table("appointments");
__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "appointments_id_seq",
  },
  "register_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "doctor_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "patient_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "date_time",
  { data_type => "timestamp with time zone", is_nullable => 1 },
  "text",
  { data_type => "text", is_nullable => 1 },
  "status",
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
__PACKAGE__->belongs_to(
  "doctor",
  "Consulta::Schema::Result::User",
  { id => "doctor_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);
__PACKAGE__->belongs_to(
  "patient",
  "Consulta::Schema::Result::User",
  { id => "patient_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);
__PACKAGE__->belongs_to(
  "register",
  "Consulta::Schema::Result::User",
  { id => "register_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07035 @ 2014-07-23 12:51:56
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:YRGdvA+mKKnHZm2xb16LRQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
