use inc::Module::Install;
name 'Tattoo';
all_from 'lib/Tattoo.pm';

# Tattoo
requires 'Mouse';

# Tattoo::Connection::SSH
requires 'Net::SSH::Perl';

# Tattoo::Action::Shell
requires 'File::Slurp';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
