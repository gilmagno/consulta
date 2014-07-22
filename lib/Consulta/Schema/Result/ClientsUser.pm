use utf8;
package Consulta::Schema::Result::ClientsUser;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';
__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp");
__PACKAGE__->table("clients_users");
__PACKAGE__->add_columns(
  "client_id",
  { data_type => "integer", is_nullable => 0 },
  "user_id",
  { data_type => "integer", is_nullable => 0 },
);
__PACKAGE__->set_primary_key("client_id", "user_id");


# Created by DBIx::Class::Schema::Loader v0.07035 @ 2014-07-21 14:51:19
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:YVDGrxCU4MpoEOsBSFQTjw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
