package Tattoo;
use Mouse;
our $VERSION = '0.01';

use Cwd;
use Clone qw( clone );
use File::Spec;
use Tattoo::Interface::Connection;
use Tattoo::Interface::Host;
use Tattoo::Deployment;

has env => ( is => 'ro', isa => 'HashRef', required => 1 );
has hosts => ( is => 'ro', isa => 'HashRef', required => 1 );
has deployment => ( is => 'ro', isa => 'HashRef', required => 1 );
has deploy => ( is => 'ro', isa => 'HashRef', required => 1 );

sub bootstrap {
    my ( $class, $tattoo_file ) = @_;
    $tattoo_file ||= File::Spec->catfile( getcwd(), 'tattoo.pl' );
    Carp::croak "could not find $tattoo_file" unless -e $tattoo_file;
    my $config = do( $tattoo_file );
    $class->new( %$config );
}

sub BUILDARGS {
    my ( $self, %args ) = @_;

    my $connections = delete $args{connections};

    for my $key ( keys %{$args{hosts}} ) {
        my $connection_name = $args{hosts}{$key}{connection};
        my $connection = Tattoo::Interface::Connection->new( %{$connections->{$connection_name}} );
        $args{hosts}{$key} = Tattoo::Interface::Host->new( 
            connection => $connection,
            host => $key,
        );
    }

    for my $key ( keys %{$args{deployment}} ) {
        $args{deployment}{$key} = Tattoo::Deployment->new( 
            name => $key, 
            actions => $args{deployment}{$key}, 
        );
    }
    
    return { %args };
}

sub exec {
    my $self = shift;
    my @rtn;
    for my $deployment_name ( keys %{$self->deployment} ) {
        for my $addr ( @{$self->deploy->{$deployment_name}} ) {
            my $host = $self->hosts->{$addr};
            for my $action ( @{ $self->deployment->{$deployment_name}->actions } ) {
                push @rtn, $action->do( $host );
            }
        }
    }
    return @rtn;
}

no Mouse;
1;
__END__

=head1 NAME

Tattoo - deploy automation

=head1 SYNOPSIS

  use Tattoo;

=head1 DESCRIPTION

Tattoo is

=head1 AUTHOR

ytnobody E<lt>ytnobody@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
