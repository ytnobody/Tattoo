package Tattoo::Trait::WithEnv;
use Mouse::Role;

has env => ( is => 'rw', isa => 'HashRef' );

sub BUILD {
    my $self = shift;
    $self->env( {} ) unless defined $self->env;
    $self->env->{DEPLOY_ENV} ||= 'development';
}

no Mouse::Role;
1;
