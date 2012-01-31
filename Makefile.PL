use inc::Module::Install;
name 'Tattoo';
all_from 'lib/Tattoo.pm';

# Tattoo
requires 'Mouse';
requires 'Clone';
requires 'File::Spec';

# Tattoo::Connection::SSH
requires 'Net::SSH::Perl';

# Tattoo::Action
requires 'Time::Piece';

# Tattoo::Action::Shell
requires 'File::Slurp';

# Tattoo::Action::Workspace::Build
requires 'Data::UUID';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
