package Tattoo::Action::Trait::ExportEnv;

use Mouse::Role;

before do => sub {
    my ( $self ) = @_;

    my $export = '';
    my $env_file = $self->env->{DEPLOY_ROOT}.'/env.sh' ;
    for my $key ( keys %{$self->env} ) {
        $export .= 'export '. $key.'='.$self->env->{$key}."\n";
    }

    unshift @{$self->exec}, join( ' ', '.', $env_file );
    unshift @{$self->exec}, join( ' ', 'chmod +x', $env_file );
    unshift @{$self->exec}, join( ' ', 'echo', "'$export'", '>', $env_file );
};

no Mouse::Role;

1;
