package Tattoo::Action::Shell;
use Mouse;
use File::Slurp;

extends qw( Tattoo::Action );

with qw( Tattoo::Trait::WithEnv );

sub BUILDARGS {
    my ( $self, %args ) = @_;
    my $script = delete $args{script};
    $args{exec} = $script ? [ map { s/\n//; $_ } read_file($script) ] : $args{exec};
    return { %args };
}

no Mouse;
1;
