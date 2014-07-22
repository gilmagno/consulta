package Consulta::View::TT;
use Moose;
use namespace::autoclean;

extends 'Catalyst::View::TT';

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.tt',
    render_die => 1,
    WRAPPER => 'wrapper.tt',
    ENCODING => 'UTF-8'
);

=head1 NAME

Consulta::View::TT - TT View for Consulta

=head1 DESCRIPTION

TT View for Consulta.

=head1 SEE ALSO

L<Consulta>

=head1 AUTHOR

sgrs,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
