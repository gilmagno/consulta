use strict;
use warnings;
use Test::More;

use Test::WWW::Mechanize::Catalyst;
use utf8;

# To test a Catalyst application named 'Catty':
my $mech = Test::WWW::Mechanize::Catalyst->new(catalyst_app => 'Consulta');

$mech->get_ok("/"); # no hostname needed
is($mech->ct, "text/html");

#$mech->title_is("Root", "On the root page");
#$mech->content_contains('placeholder="Login"', "Login page");
#$mech->follow_link_ok({text => 'Hello'}, "Click on Hello");
# ... and all other Test::WWW::Mechanize methods
# White label site testing
#$mech->host("foo.com");
#$mech->get_ok("/");

$mech->content_contains('placeholder="Login"', "carregando pagina de login");

my $credentials;

$credentials = { username => 'carlosmoura', password => 'senha' };
$mech->post_ok('/entrar', $credentials, 'logando');
$mech->content_contains('<h1>Início', "Página Inicial");

$mech->follow_link_ok({ text_regex => qr/Sair/ }, 'deslogando');
$mech->content_contains('placeholder="Login"', "carregando pagina de login");

$mech->post_ok('/entrar', $credentials, 'login ok');
$mech->content_contains('<h1>Início', "Página Inicial");

$mech->follow_link_ok({ text_regex => qr/Agenda/ }, 'clique no link agenda');
$mech->content_contains('<h1>Agenda', "agenda index");

$mech->follow_link_ok({ text_regex => qr/Pacientes/ }, 'clique no link pacientes');
$mech->content_contains('<h1>Pacientes', "pacientes index");

$mech->follow_link_ok({ text_regex => qr/Gil Magno/ }, 'clique no paciente gil magno');
$mech->content_contains('<h1>Gil Magno', "loading patients/details gil magno");

$mech->follow_link_ok({ text_regex => qr/Consultas/ }, 'clique no link consultas');
$mech->content_contains('Consultas</h1>',
                        "loading patients/consultations/index gil magno");

done_testing();
