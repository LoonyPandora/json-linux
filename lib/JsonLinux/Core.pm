package JsonLinux::Core;

use common::sense;

use Data::Dump qw(dump);
use IPC::Cmd qw(run run_forked QUOTE);
use MIME::Base64;
use Dancer::App;
use Dancer ':syntax';
use URI::Escape;
use IPC::System::Simple qw(system systemx capture capturex);

use String::ShellQuote qw(shell_quote);

# Core stuff
sub run_command {
    my ($args) = @_;

    $args->{user} =~ s/\W+//ag;
    $args->{pass} =~ s/\W+//ag;

    
    return qx/echo $args->{pass} | sudo -S -u $args->{user} $args->{command}/;
}



sub ipc_run_command {
    my ($args) = @_;

    # Defaults targetpw

    # Authorization Basic dmFncmFudDonO2xzO1wnQCcnIXw+I145MC1fKSgkJDsoOn17JTIwJTM0XCc=
    # vagrant:';ls;\'@''!|>#^90-_)($$;(:}{%20%34\'

    # Authorization Basic dmFncmFudDp2YWdyYW50
    # vagrant:vagrant

    # Authorization Basic dGVzdDp0ZXN0
    # test:test

    my $authorization = request->header('Authorization');

    if (defined $authorization && $authorization =~ /^Basic (.*)$/) {
        my ($user, $pass) = split(/:/, (MIME::Base64::decode($1) || ":"));

        # Check for nulls?? s/\x00$//;

        $user = shell_quote($user);

        my $hashref = run_forked("export SUDO_ASKPASS=/dev/shm/pass.sh; /usr/bin/sudo -Au $user tee /home/test/out.txt ", {
            child_stdin => "asdfasdfsadfasdf"
        });
        
        return $hashref;
    } else {

    }

}


1;
