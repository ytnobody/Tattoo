package Tattoo::Action::Workspace::Build;
use Mouse;
extends qw( Tattoo::Action );

use Data::UUID;

sub BUILD {
    my $self = shift;
    $self->env->{WORKSPACE} ||= '/tmp/tattoo/'. Data::UUID->new->create_hex;
    my $workspace = $self->env->{WORKSPACE};
    $self->exec([ "mkdir -p $workspace" ]);
}

no Mouse;
1;
