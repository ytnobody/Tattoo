package Tattoo::Action::Deploy;
use Mouse;
extends qw( Tattoo::Action );

before do => sub {
    my ( $self ) = @_;
    unshift @{$self->exec}, 'ln -s $(pwd)/$(ls -tp | sed -n \'/\/$/p\' | head -n 1) ./current';
    unshift @{$self->exec}, 'if [ -e ./current ] ; then rm ./current ; fi';
    unshift @{$self->exec}, 'cd $DEPLOY_ROOT';
    unshift @{$self->exec}, 'cp -arv $WORKSPACE $DEPLOY_ROOT/';
    unshift @{$self->exec}, '[ -d "$DEPLOY_ROOT" ] || mkdir -p $DEPLOY_ROOT';
};

no Mouse;
1;
