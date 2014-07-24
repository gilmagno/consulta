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

my $credentials = { username => 'gilmagno', password => 'senha' };
my $user_id = 4;

$mech->post_ok('/entrar', $credentials, 'logando');
$mech->content_lacks('<h1>Início', "nao estamos na Página Inicial");
$mech->content_lacks('Início</a>', "nao ha link inicio no menu inicial");
$mech->content_lacks('Pacientes</a>', "nao ha link pacientes no menu inicial");
$mech->content_lacks('Agenda</a>', "nao ha link agenda no menu inicial");

$mech->follow_link_ok({ text_regex => qr/Sair/ }, 'deslogando');
$mech->content_contains('placeholder="Login"', "carregando pagina de login");

$mech->post_ok('/entrar', $credentials, 'login ok');

$mech->content_contains('<h1>Gil Magno',
                        "pagina apos login eh patients/details gil magno");

diag 'Checking links on secondary menu';

$mech->content_lacks('Voltar</a>', "nao ha link voltar no menu secundario");
$mech->content_lacks('Editar</a>', "nao ha link editar no menu secundario");
$mech->content_lacks('Login e Senha</a>',
                     "nao ha link login e senha no menu secundario");
$mech->content_lacks('Nova Consulta</a>',
                     "nao ha link nova consulta no menu secundario");



$mech->follow_link_ok({ text_regex => qr/Consultas/ }, 'clique no link consultas');
$mech->content_contains('Consultas</h1>',
                        "loading patients/consultations/index gil magno");



diag 'Trying to access forbiden links directly';

$mech->get('/pacientes', 'loading /patients/index');
$mech->content_contains('Não autorizado/a', 'Direct access to /pacientes forbiden.');

$mech->get("/pacientes/$user_id/editar", 'Loading /patients/edit');
$mech->content_contains('Não autorizado/a',
                        'Direct access to /patients/edit forbiden.');

$mech->get("/pacientes/$user_id/senha", 'Loading /patients/password');
$mech->content_contains('Não autorizado/a',
                        'Direct access to /patients/password forbiden.');

$mech->get("/pacientes/$user_id/consultas/criar",
           'Loading /patients/consultations/create');
$mech->content_contains('Não autorizado/a',
                        'Direct access to /patients/consultations/create forbiden.');

$mech->get('/', 'Loading /');
$mech->content_contains('Não autorizado/a',
                        'acesso direto a / deve ser proibido' );

#$mech->get('/agenda', 'loading appointments');
#$mech->content_contains('Não autorizado/a',
#                        'acesso direto a /agenda deve ser proibido' );

done_testing();
