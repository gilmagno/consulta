use utf8;
package Consulta::Schema::Result::City;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';
__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp");
__PACKAGE__->table("cities");
__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "cities_id_seq",
  },
  "state_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "name",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->belongs_to(
  "state",
  "Consulta::Schema::Result::State",
  { id => "state_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);
__PACKAGE__->has_many(
  "users",
  "Consulta::Schema::Result::User",
  { "foreign.address_city_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07035 @ 2014-07-16 15:43:21
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:wb5nEO1plg0AlzEL9vHnsw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
