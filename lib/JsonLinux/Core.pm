package JsonLinux::Core;

use common::sense;
use Data::Dump qw(dump);

# Core stuff
sub run_command {
    my ($args) = @_;

    $args->{user} =~ s/\W+//ag;
    $args->{pass} =~ s/\W+//ag;

    return qx/echo $args->{pass} | sudo -S -u $args->{user} $args->{command}/;
}


1;
