package Tattoo::Action::Shell;
use Mouse;
use File::Slurp;

has verbose => ( is => 'ro', isa => 'Bool', default => 1 );

extends qw( Tattoo::Action );

with qw( Tattoo::Trait::WithEnv );

sub BUILDARGS {
    my ( $self, %args ) = @_;
    my $script = delete $args{script};
    $args{exec} = $script ? [ map { s/\n//; $_ } read_file($script) ] : $args{exec};
    return { %args };
}

around do => sub {
    my ( $next, $self, @args ) = @_;
    my $rtn = $self->$next( @args );
    $self->info( "Execute Result\n". $rtn ) if $self->verbose;
    return $rtn;
};

no Mouse;
1;
