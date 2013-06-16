package JsonLinux::API::cpuinfo;

use Dancer ':syntax';
use Dancer::App;

use common::sense;


get "/cpuinfo" => sub {
    return [qw(cpuinfo)];
};


1;
