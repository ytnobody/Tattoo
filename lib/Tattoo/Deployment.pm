package Tattoo::Deployment;
use Mouse;
use Mouse::Util;

with qw( Tattoo::Trait::WithEnv );

has name => ( is => 'rw', isa => 'Str' );
has actions => ( is => 'ro', isa => 'ArrayRef', default => sub { [] } );

sub BUILDARGS {
    my ( $self, %args ) = @_;

    my @actions = (
        'Workspace::Build' => {},
        @{ delete $args{actions} },
        'Workspace::Cleanup' => {},
    );

    $args{actions} = [];
    $args{env} ||= {};

    $args{env}{NAME} = $args{name};
    $args{env}{DEPLOY_ROOT} ||= '/tmp/'.$args{name};

    while ( @actions ) {
        my $class = shift @actions;
        my $options = shift @actions;
        my $klass = join '::', 'Tattoo::Action', $class;
        unless( Mouse::Util::is_class_loaded( $klass ) ) {
            Mouse::Util::load_class( $klass );
        }

        push @{$args{actions}}, $klass->new( %$options, env => $args{env} );
    }

    return { %args };
}

no Mouse;
1;
