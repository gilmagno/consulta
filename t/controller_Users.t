use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Consulta';
use Consulta::Controller::Users;

ok( request('/use')->is_success, 'Request should succeed' );
done_testing();
