use strict;
use Test::More;
use Tattoo;
use File::Spec;

my $t = Tattoo->bootstrap( File::Spec->catfile( 't', 'tattoo.pl' ) );
diag explain $t;
diag '---';

diag explain $t->exec;

ok 1;
done_testing;
