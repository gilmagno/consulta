use utf8;
package Consulta::Schema::Result::ConsultationFile;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';
__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp");
__PACKAGE__->table("consultation_files");
__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "consultation_files_id_seq",
  },
  "consultation_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "filename",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->belongs_to(
  "consultation",
  "Consulta::Schema::Result::Consultation",
  { id => "consultation_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07035 @ 2014-07-21 14:51:19
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:XKMJu4Npzi9hW+CJGH/EfA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
