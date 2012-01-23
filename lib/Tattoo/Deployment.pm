package Tattoo::Deployment;
use Mouse;
use Mouse::Util;

has name => ( is => 'ro', isa => 'Str', required => 1 );
has actions => ( is => 'ro', isa => 'ArrayRef', default => sub { [] } );

sub BUILDARGS {
    my ( $self, %args ) = @_;
    my @actions = @{ delete $args{actions} };
    $args{actions} = [];
    while ( @actions ) {
        my $class = shift @actions;
        my $options = shift @actions;
        my $klass = join '::', 'Tattoo::Action', $class;
        unless( Mouse::Util::is_class_loaded( $klass ) ) {
            Mouse::Util::load_class( $klass );
        }
        push @{$args{actions}}, $klass->new( %$options );
    }
    return { %args };
}

no Mouse;
1;
