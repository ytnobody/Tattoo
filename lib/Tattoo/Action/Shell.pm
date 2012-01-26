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
    my ( $self, $connection ) = @_;
    my @res;
    for my $cmd ( @{$self->exec} ) {
        my ( $stdout, $stderr, $exit ) = $connection->cmd( $cmd );
        if ( $exit ) {
            warn $stderr;
        }
        else {
            push @res, $stdout;
        }
    }
    return wantarray ? @res : join "\n", @res;
}

no Mouse;
1;
