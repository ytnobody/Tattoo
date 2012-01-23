package Tattoo::Interface::Host;
use Mouse;

has connection => ( is => 'ro', required => 1 );
has host => ( is => 'ro', isa => 'Str', required => 1 );

sub connect {
    my $self = shift;
    $self->connection->connect( $self->host );
}

no Mouse;
1;
