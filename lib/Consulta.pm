package Consulta;
use Moose;
use namespace::autoclean;

use Catalyst::Runtime 5.80;

use Catalyst qw/
    -Debug
    ConfigLoader
    Static::Simple
    StackTrace

    Authentication
    Authorization::RoleAbilities

    Session
    Session::Store::FastMmap
    Session::State::Cookie
/;

extends 'Catalyst';

our $VERSION = '0.01';

# Configure the application.
#
# Note that settings in consulta.conf (or other external
# configuration file that you set up manually) take precedence
# over this when using ConfigLoader. Thus configuration
# details given here can function as a default configuration,
# with an external configuration file acting as an override for
# local deployment.

__PACKAGE__->config(
    name => 'Consulta',

    # Disable deprecated behavior needed by old applications
    disable_component_resolution_regex_fallback => 1,

    enable_catalyst_header => 1, # Send X-Catalyst header

    encoding => 'UTF-8',

    default_model => 'DB',

    'Plugin::Authentication' => {
        default_realm => 'members',
        members => {
            credential => {
                class => 'Password',
                password_field => 'password',
                password_type => 'clear'
               },
            store => {
                class => 'DBIx::Class',
                user_model => 'DB::User',
                role_relation => 'roles',
                role_field => 'name'
            },
        },
    },
);

# Start the application
__PACKAGE__->setup();

1;
