package Tattoo::Action::Workspace::Cleanup;
use Mouse;
extends qw( Tattoo::Action::Shell );

sub BUILD {
    my $self = shift;
    my $workspace = $self->env->{WORKSPACE};
    $self->exec([
        'cd $HOME',
        "rm -vrf $workspace",
    ]);
}

no Mouse;
1;
