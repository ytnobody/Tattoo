use strict;
use Test::More;
use Tattoo;
use File::Spec;

my $t = Tattoo->bootstrap( File::Spec->catfile( 't', 'tattoo.pl' ) );
diag explain $t;
diag '---';

use Data::Dumper;
warn Dumper( $t->exec );

ok 1;
done_testing;
