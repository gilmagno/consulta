use strict;
use warnings;

use Consulta;

my $app = Consulta->apply_default_middlewares(Consulta->psgi_app);
$app;

