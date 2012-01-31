package Tattoo::Action::Workspace::Cleanup;
use Mouse;
extends qw( Tattoo::Action );
with qw( Tattoo::Action::Trait::AtWorkspace );

sub BUILD {
    my $self = shift;
    my $workspace = $self->env->{WORKSPACE};
    $self->exec([
        'cd $HOME',
        "rm -rf $workspace",
    ]);
}

no Mouse;
1;
