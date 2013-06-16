package JsonLinux;

use Dancer ":syntax";
use common::sense;


our $VERSION = "0.1.0";




get "/" => sub {
    return [qw(hello foo bar)];
};


get "/cpu" => sub {
    my $result = qx/sysctl -n machdep.cpu.brand_string/;
    chomp($result);

    return { cpu => $result };
};


1;
