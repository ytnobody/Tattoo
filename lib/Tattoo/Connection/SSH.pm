package Tattoo::Connection::SSH;
use Mouse;
use Net::SSH::Perl;

has user => ( is => 'ro', isa => 'Str', default => 'root' );
has password => ( is => 'ro', isa => 'Str', required => 1 );
has options => ( is => 'ro', isa => 'HashRef', default => sub { {} } );

sub BUILDARGS {
    my ( $self, %args ) = @_;
    my $user = delete $args{user} || 'root';
    my $password = delete $args{password};
    return { 
        user => $user, 
        password => $password, 
        options => {%args},
    };
}

sub connect {
    my ( $self, $host ) = @_;
    my $ssh = Net::SSH::Perl->new( $host, %{$self->options} );
    $ssh->login( $self->user, $self->password ) 
        or Carp::croak sprintf( "%s: Authentication failure (host=%s)", __PACKAGE__, $host );
    return $ssh;
}

no Mouse;
1;
