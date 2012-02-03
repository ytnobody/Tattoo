package Tattoo::Connection::SSH::Session;

use strict;
use parent qw( Net::SSH::Perl );
use Net::SFTP;
use SUPER;

sub login {
    my ( $self, $user, $pass ) = @_;
    my $host = $self->{host};
    $self->super('login')->( $self, $user, $pass );
    $self->sftp( Net::SFTP->new( $host, user => $user, password => $pass ) );
}

sub sftp {
    my $self = shift;
    $self->{sftp} = $_[0] if defined $_[0];
    return $self->{sftp};
}

1;
