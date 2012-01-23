package Tattoo::Action::Shell;
use Mouse;
use File::Slurp;

has exec => ( is => 'ro', isa => 'ArrayRef', required => 1 );

sub BUILDARGS {
    my ( $self, %args ) = @_;
    my $script = delete $args{script};
    $args{exec} = $script ? [ map { s/\n//; $_ } read_file($script) ] : $args{exec};
    return { %args };
}

sub do {
    my ( $self, $host ) = @_;
    my $connect = $host->connect;
    for my $cmd ( @{$self->exec} ) {
        my ( $stdout, $stderr, $exit ) = $connect->cmd( $cmd );
    }
}

no Mouse;
1;
