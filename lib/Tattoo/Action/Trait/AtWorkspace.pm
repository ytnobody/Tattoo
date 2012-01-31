package Tattoo::Action::Trait::AtWorkspace;

use Mouse::Role;

before do => sub {
    my ( $self ) = @_;
    if ( $self->env->{WORKSPACE} ) {
        my $workspace = $self->env->{WORKSPACE};
        unshift @{$self->exec}, "[ -e '$workspace' ] && cd $workspace";
    }
};

no Mouse::Role;

1;
