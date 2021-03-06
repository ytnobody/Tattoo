package Tattoo::Action;
use Mouse;
use Time::Piece;

with qw( Tattoo::Trait::WithEnv Tattoo::Action::Trait::ExportEnv );

has exec => ( is => 'rw', default => sub { [] } );
has verbose => ( is => 'ro', isa => 'Bool', default => 0 );

around do => sub {
    my ( $next, $self, @args ) = @_;
    $self->info( 'Started to processing.' );
    my $rtn = $self->$next( @args );
    $self->info( "Execute Result\n". $rtn ) if $self->verbose && $rtn;
    $self->info( 'Finished processing.' );
    return $rtn;
};

sub time {
    localtime->strftime( '%Y-%m-%d %H:%M:%S' );
}

sub do {
    my ( $self, $connection ) = @_;

    my ( $stdout, $stderr, $exit ) = $connection->cmd( join ' && ', @{$self->exec} );
    if ( $exit ) {
        $self->error( $stderr, $exit );
    }
    else {
        return $stdout;
    }
}

sub cmd {
    my ( $self, @cmd ) = @_;
    push @{$self->exec}, join( ' ', @cmd );
}

sub info {
    my ( $self, $mes ) = @_;
    my $package = ref $self;
    printf "%s [%s %s] INFO: %s \n", $self->time, $self->name, $package, $mes;
}

sub warn {
    my ( $self, $mes ) = @_;
    my $package = ref $self;
    print STDERR sprintf "%s [%s %s] WARN: %s \n", $self->time, $self->name, $package, $mes;
}

sub error {
    my ( $self, $mes, $exit ) = @_;
    my $package = ref $self;
    print STDERR sprintf "%s [%s %s] ERROR: %s (exit_code=%d)\n", $self->time, $self->name, $package, $mes, $exit;
    exit( $exit );
}

sub name {
    my ( $self ) = @_;
    return $self->env->{NAME};
}

no Mouse;
1;
