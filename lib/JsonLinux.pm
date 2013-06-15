package JsonLinux;
use Dancer ":syntax";

use common::sense;

our $VERSION = "0.1.0";

get "/" => sub {
    return [qw(hello foo bar)];

};

true;
