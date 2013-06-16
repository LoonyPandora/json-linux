package JsonLinux::API::meminfo;

use Dancer ':syntax';
use Dancer::App;

use common::sense;

use JsonLinux::Core;


get "/meminfo" => sub {
    my @raw = JsonLinux::Core::run_command({
        user    => "vagrant",
        pass    => "vagrant",
        command => "/bin/cat /proc/meminfo",
    });

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
