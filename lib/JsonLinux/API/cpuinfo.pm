package JsonLinux::API::cpuinfo;

use Dancer ':syntax';
use Dancer::App;

use common::sense;


get "/cpuinfo" => sub {
    my @raw = qx{/bin/cat /proc/cpuinfo};

    my @processor;
    my $proc = 0;
    for my $line (@raw) {
        if ($line =~ /^\n$/) {
            $proc++;
        }

        my ($key, $value) = split(":", $line);
        chomp($key, $value);
        $key   =~ s/\t+//g;
        $value =~ s/^\s+//g;

        if ($key) {
            if ($key eq "flags") {
                $processor[$proc]{$key} = [split(" ", $value)];
            } else {
                $processor[$proc]{$key} = $value;
            }
        }
    }

    return \@processor;
};


1;
