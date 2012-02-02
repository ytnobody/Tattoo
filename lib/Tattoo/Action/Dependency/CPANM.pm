package Tattoo::Action::Dependency::CPANM;
use Mouse;

extends qw( Tattoo::Action );
with qw( Tattoo::Action::Trait::AtWorkspace );

has mirror => ( is => 'ro' );
has mirror_only => ( is => 'ro', isa => 'Bool', default => 0 );

sub BUILD {
    my $self = shift;
    my @cmd = ( 'cpanm', '-l', 'extlib', '--installdeps', '.' );
    if ( defined $self->mirror ) {
        push @cmd, '--mirror', $self->mirror;
    }
    if ( $self->mirror_only ) {
        push @cmd, '--mirror_only';
    }
    $self->cmd( @cmd );
    $self->cmd( 'cat', '~/.cpanm/build.log' );
}

no Mouse;
1;
