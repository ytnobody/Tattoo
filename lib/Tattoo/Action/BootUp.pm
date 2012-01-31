package Tattoo::Action::BootUp;
use Mouse;
extends qw( Tattoo::Action );

before do => sub {
    my ( $self ) = @_;
    my $deployroot = $self->env->{DEPLOY_ROOT};
    unshift @{$self->exec}, 'ln -sf $(pwd)/$(ls -tp | sed -n \'/\/$/p\' | head -n 1) ./current && cd ./current';
    unshift @{$self->exec}, "cd $deployroot";
    unshift @{$self->exec}, join( ' ', 'cp -arv', $self->env->{WORKSPACE}, "$deployroot/" );
    unshift @{$self->exec}, '[ -d "'.$deployroot.'" ] || mkdir -p '.$deployroot;
};

no Mouse;
1;
