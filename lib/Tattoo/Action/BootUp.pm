package Tattoo::Action::BootUp;
use Mouse;
extends qw( Tattoo::Action );
with qw( Tattoo::Action::Trait::AtDeployRoot );

no Mouse;
1;
