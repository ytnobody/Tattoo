package Tattoo::Action::Trait::AtDeployRoot;

use Mouse::Role;

before do => sub {
    my ( $self ) = @_;
    if ( $self->env->{DEPLOY_ROOT} ) {
        my $deployroot = $self->env->{DEPLOY_ROOT};
        unshift @{$self->exec}, "[ -e '$deployroot' ] && cd $deployroot";
    }
};

no Mouse::Role;

1;
