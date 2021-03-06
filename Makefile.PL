#!/usr/bin/env perl
# IMPORTANT: if you delete this file your app will not work as
# expected.  You have been warned.
use inc::Module::Install 1.02;
use Module::Install::Catalyst; # Complain loudly if you don't have
                               # Catalyst::Devel installed or haven't said
                               # 'make dist' to create a standalone tarball.

name 'Consulta';
all_from 'lib/Consulta.pm';

requires 'Catalyst::Runtime' => '5.90053';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Action::RenderView';
requires 'Moose';
requires 'namespace::autoclean';
requires 'Config::General'; # This should reflect the config file format you've chosen
                 # See Catalyst::Plugin::ConfigLoader for supported formats

requires 'Catalyst::Model::DBIC::Schema';
requires 'Catalyst::View::TT';
requires 'MooseX::NonMoose';
requires 'DBIx::Class::TimeStamp';
requires 'DBD::Pg';
requires 'Catalyst::Plugin::Session::State::Cookie';
requires 'Catalyst::Plugin::Session::Store::FastMmap';
requires 'Catalyst::Plugin::Authorization::RoleAbilities';
requires 'Catalyst::Plugin::StackTrace';
requires 'Catalyst::Authentication::Store::DBIx::Class';
requires 'HTML::FormFu';
requires 'DateTime::Format::Pg';
requires 'HTML::FormFu::Model::DBIC';

test_requires 'Test::More' => '0.88';
test_requires 'Test::WWW::Mechanize::Catalyst';

catalyst;

install_script glob('script/*.pl');
auto_install;
WriteAll;
