package JsonLinux::API::echo;

use Dancer ':syntax';
use Dancer::App;

use common::sense;

use JsonLinux::Core;



# We deliberately do NOT use echo and shell redirects, because we never invoke a shell
# Therefore to actually write files we need a non linux utility.
# This also has the advantage of not needing to escape stuff




# Defaults    env_reset
# #Defaults    exempt_group=admin
# Defaults    targetpw
# Defaults    timestamp_timeout=0
# Defaults    secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
# 
# # Host alias specification
# 
# # User alias specification
# 
# # Cmnd alias specification
# 
# # User privilege specification
# root    ALL=(ALL:ALL) ALL
# 
# # Members of the admin group may gain root privileges
# %admin ALL=(ALL) NOPASSWD:ALL
# 
# # Allow members of group sudo to execute any command
# %sudo    ALL=(ALL:ALL) ALL
# 
# # See sudoers(5) for more information on "#include" directives:
# 
# #includedir /etc/sudoers.d



# Use TEE
any "/echo" => sub {

    my $content = q{asdf};


    # It's not possible to securely get echo to work directly
    # So we fake it if we want to redirect to a file, and use Perl to write it.



    my $ref = JsonLinux::Core::ipc_run_command({
        command   => "echo",
        flags     => [],
        arguments => [$content, ">", "out.txt"],
    });

    return $ref;
};


1;
