package Tattoo::Action::BootUp::Starlet;
use Mouse;
extends qw( Tattoo::Action::BootUp );

has pid_file => ( is => 'ro', isa => 'Str', required => 1 );
has log_file => ( is => 'ro', isa => 'Str', required => 1 );
has psgi_file => ( is => 'ro', isa => 'Str', default => 'app.psgi' );
has port => ( is => 'ro', isa => 'Str', default => '127.0.0.1:3000' );
has max_workers => ( is => 'ro', isa => 'Int', default => 2 );

sub BUILDARGS {
    my ( $self, %args ) = @_;
    $args{pid_file} ||= $args{env}{DEPLOY_ROOT}.'/pid_file';
    $args{log_file} ||= $args{env}{DEPLOY_ROOT}.'/access_log';
    return { %args };
}

sub BUILD {
    my $self = shift;

    $self->cmd( 'pwd' );
    $self->cmd( 'ls -l' );

#    $self->cmd( 
#         '[ -e "'.$self->pid_file.'" ] && kill $(cat '.$self->pid_file.')',
#         join( 
#             ' ', 'start_server', 
#             '--pid' => $self->pid_file,
#             '--port' => $self->port,
#             '--' => 'plackup',
#             '-s' => 'Starlet',
#             '--max-workers' => $self->max_workers,
#             '-I' => 'extlib/lib/perl5', 
#             '-I' => 'lib', 
#             $self->psgi_file, 
#             '>' => $self->log_file, '2>&1', '&',
#         ),
#    );
}

no Mouse;
1;
