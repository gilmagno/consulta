use utf8;
package Consulta::Schema::Result::RoleAction;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';
__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp");
__PACKAGE__->table("role_actions");
__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "role_actions_id_seq",
  },
  "role_id",
  { data_type => "integer", is_nullable => 1 },
  "action_id",
  { data_type => "integer", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07035 @ 2014-07-21 14:51:19
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:zspt8vB4YA3U3ng49g9BOA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
