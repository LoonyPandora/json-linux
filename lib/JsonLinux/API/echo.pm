package JsonLinux::API::echo;

use Dancer ':syntax';
use Dancer::App;

use common::sense;

use JsonLinux::Core;

any "/echo" => sub {
    my $ref = JsonLinux::Core::ipc_run_command({
        command => qq{echo "hello"; ls -lah}
    });

    return $ref;
};


1;
