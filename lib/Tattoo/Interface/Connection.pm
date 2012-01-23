package Tattoo::Interface::Connection;
use Mouse;
use Mouse::Util;

sub new {
    my ( $class, %args ) = @_;
    my $type = delete $args{type} || 'SSH';
    my $klass = join '::', 'Tattoo::Connection', $type;
    unless ( Mouse::Util::is_class_loaded( $klass ) ) {
        Mouse::Util::load_class( $klass );
    }
    $klass->new( %args );
}

no Mouse;
1;

