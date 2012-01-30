package Tattoo::Action;
use Mouse;

with qw( Tattoo::Trait::WithEnv );

has exec => ( is => 'rw', default => sub { [] } );

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

sub cmd {
    my ( $self, @cmd ) = @_;
    push @{$self->exec}, join( ';', @cmd );
}

no Mouse;
1;
