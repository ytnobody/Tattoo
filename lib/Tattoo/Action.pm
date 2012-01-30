package Tattoo::Action;
use Mouse;
use Time::Piece;

with qw( Tattoo::Trait::WithEnv );

has exec => ( is => 'rw', default => sub { [] } );

around do => sub {
    my ( $next, $self, @args ) = @_;
    $self->info( 'Started to processing.' );
    my $rtn = $self->$next( @args );
    $self->info( 'Finished processing.' );
    return $rtn;
};

sub time {
    localtime->strftime( '%Y-%m-%d %H:%M:%S' );
}

sub do {
    my ( $self, $connection ) = @_;

    if ( $self->env->{WORKSPACE} ) {
        my $workspace = $self->env->{WORKSPACE};
        unshift @{$self->exec}, "[ -e '$workspace' ] && cd $workspace";
    }

    my ( $stdout, $stderr, $exit ) = $connection->cmd( join ';', @{$self->exec} );
    if ( $exit ) {
        $self->error( $stderr, $exit );
    }
    else {
        return $stdout;
    }
}

sub cmd {
    my ( $self, @cmd ) = @_;
    push @{$self->exec}, join( ';', @cmd );
}

sub info {
    my ( $self, $mes ) = @_;
    my $package = ref $self;
    printf "%s [%s] INFO %s \n", $self->time, $package, $mes;
}

sub warn {
    my ( $self, $mes ) = @_;
    my $package = ref $self;
    print STDERR sprintf "%s [%s] WARN %s \n", $self->time, $package, $mes;
}

sub error {
    my ( $self, $mes, $exit ) = @_;
    my $package = ref $self;
    print STDERR sprintf "%s [%s] WARN %s (exit_code=%d)\n", $self->time, $package, $mes, $exit;
    exit( $exit );
}

no Mouse;
1;
