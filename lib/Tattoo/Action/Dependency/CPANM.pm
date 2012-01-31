package Tattoo::Action::Dependency::CPANM;
use Mouse;

extends qw( Tattoo::Action );

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
    $self->cmd(
        join( ' ', @cmd ), 
        join( ' ', 'cat ~/.cpanm/build.log' ),
    );
}

no Mouse;
1;
