package Tattoo::Action::Shell;
use Mouse;
use File::Slurp;

with qw( Tattoo::Trait::WithEnv );

has exec => ( is => 'rw' );

sub BUILDARGS {
    my ( $self, %args ) = @_;
    my $script = delete $args{script};
    $args{exec} = $script ? [ map { s/\n//; $_ } read_file($script) ] : $args{exec};
    return { %args };
}

sub do {
    my ( $self, $connection ) = @_;

    if ( $self->env->{WORKSPACE} ) {
        my $workspace = $self->env->{WORKSPACE};
        unshift @{$self->exec}, "[ -e '$workspace' ] && cd $workspace";
    }

    my ( $stdout, $stderr, $exit ) = $connection->cmd( join ';', @{$self->exec} );
    if ( $exit ) {
        die "exit_code( $exit ): $stderr";
    }
    else {
        return $stdout;
    }
}

no Mouse;
1;
