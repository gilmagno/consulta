package Consulta::Controller::Appointments;
use Moose;
use namespace::autoclean;

use HTML::FormFu;

BEGIN { extends 'Catalyst::Controller' }

sub base :Chained('/') PathPart('agenda') CaptureArgs(0) {
    my ($self, $c) = @_;
}

sub object :Chained('base') PathPart('') CaptureArgs(1) {
    my ($self, $c, $user_id) = @_;
}

sub index :Chained('base') PathPart('') Args(0) {
    my ($self, $c) = @_;
}

__PACKAGE__->meta->make_immutable;

1;
