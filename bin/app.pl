#!/usr/bin/env perl

use Dancer;
use DirHandle;
use JsonLinux;
use Path::Tiny qw(path);

# Make sure we have the correct env, no matter where we are launched from
my $lib = path($0)->absolute->parent->parent . "/lib";
push @INC, $lib;


# Get a list of all modules
my $lib_handle = DirHandle->new("$lib/JsonLinux/API/");
my @modules = grep { -f "$lib/JsonLinux/API/$_" && /\.pm$/ } $lib_handle->read;
undef $lib_handle;


# Each command is it's own Dancer app. Load them in alphabetical order
for my $module_path (sort @modules) {
    my $module = "JsonLinux::API::" . $module_path =~ s/\.pm//gr ;

    load_app($module);
}


# Get things running
dance();

