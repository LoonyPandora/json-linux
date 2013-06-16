package JsonLinux::API::meminfo;

use Dancer ':syntax';
use Dancer::App;

use common::sense;


get "/meminfo" => sub {
    my @raw = qx{/bin/cat /proc/meminfo};

    my %output;
    for my $line (@raw) {
        my ($key, $value) = split(":", $line);
        chomp($key, $value);
        $key   =~ s/\t+//g;
        $value =~ s/^\s+//g;

        $output{$key} = $value

    }

    return \%output;
};


1;
