package Tattoo::Action::Clone::Git;
use Mouse;

extends qw( Tattoo::Action );
with qw( Tattoo::Action::Trait::AtWorkspace );

has repository => ( is => 'ro', isa => 'Str', required => 1 );
has branch => ( is => 'ro', isa => 'Str', default => 'master' );
has commit_id => ( is => 'ro', default => undef );

sub BUILD {
    my $self = shift;
    $self->cmd( 
        'which git',
        join( ' ', 'git clone', $self->repository, $self->env->{WORKSPACE} ),
        join( ' ', 'git checkout', $self->branch ),
    );
    if ( $self->commit_id ) {
        $self->cmd( 'git checkout '.$self->commit_id );
    }
}

no Mouse;
1;
