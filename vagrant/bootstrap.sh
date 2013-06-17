#!/usr/bin/env bash

apt-get update
apt-get install -y curl make

curl -L http://cpanmin.us | perl - App::cpanminus

cpanm -n --sudo Modern::Perl Plack Dancer common::sense YAML JSON Path::Tiny Data::Dump Carp IPC::Cmd MIME::Base64 IPC::System::Simple String::ShellQuote
