package JsonLinux::Core;

use common::sense;

use Data::Dump qw(dump);
use IPC::Cmd qw(run QUOTE);
use MIME::Base64;
use Dancer::App;
use Dancer ':syntax';
use URI::Escape;


# Core stuff
sub run_command {
    my ($args) = @_;

    $args->{user} =~ s/\W+//ag;
    $args->{pass} =~ s/\W+//ag;

    
    return qx/echo $args->{pass} | sudo -S -u $args->{user} $args->{command}/;
}



sub ipc_run_command {
    my ($args) = @_;

    # Authorization Basic dmFncmFudDonO2xzO1wnQCcnIXw+I145MC1fKSgkJDsoOn17JTIwJTM0XCc=
    # vagrant:';ls;\'@''!|>#^90-_)($$;(:}{%20%34\'

    # Authorization Basic dmFncmFudDp2YWdyYW50
    # vagrant:vagrant

    my $authorization = request->header('Authorization');

    if (defined $authorization && $authorization =~ /^Basic (.*)$/) {
        my ($user, $pass) = split(/:/, (MIME::Base64::decode($1) || ":"));

        my $cmd = $args->{command};

        # Username and password can be anything - so just uri escape them
        # The command is not user-provided - so no need to escape that
        $pass = uri_escape($pass);
        $user = uri_escape($user);

        # cross-platform shell quote character
        my $q = QUOTE();

        my ($success, $error_message, $full_buf, $stdout_buf, $stderr_buf) = run(
            command => "echo $q$pass$q | sudo -S -u $q$user$q $cmd",
            verbose => 0
        );

        return [$success, $error_message, $full_buf, $stdout_buf, $stderr_buf];
    } else {

    }

}


1;
