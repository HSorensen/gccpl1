#!/bin/sh
#
# Wrapper for makeinfo for the texinfo VS Code extension. Set path to makeinfo.sh
# Build docker image as 
# docker build -f _docker/dockerfile_texinfo -t itsme/texinfo .
#
IMAGE=itsme/texinfo

# TODO: Derive USR and PRJ from environment
USR=/Users/hsorensen
PRJ=github/gccpl1

V1=$USR/.vscode/extensions/cismonx.texinfo-0.2.4:$USR/.vscode/extensions/cismonx.texinfo-0.2.4
V2=$USR/$PRJ:$USR/$PRJ
W=$USR/$PRJ

# All arguments as array
args=("$@")
# Get filename as the last argument
fn_ix=$#-1 
FILENAME=${args[$fn_ix]}

# Start makeinfo without -D __vscode_texinfo_image_uri_base argument.
docker run --rm --hostname texinfo -v $V1 -v $V2 --workdir $W -t $IMAGE makeinfo -o- --no-split --html --error-limit=100 --init-file=$USR/.vscode/extensions/cismonx.texinfo-0.2.4/ext/html-preview.pm -c EXTRA_HEAD="<script>window.addEventListener('message', event => {const message = event.data;switch (message.command) {case 'goto':window.location.hash = message.value;history.pushState('', '', window.location.pathname);break;}})</script>" $FILENAME
exit $?

# Rest of file is just for reference of how the vscode extension is implemented

Command as invoked from extension (defunct):
makeinfo -o- --no-split --html --error-limit=100 --init-file=/Users/hsorensen/.vscode/extensions/cismonx.texinfo-0.2.4/ext/html-preview.pm -D __vscode_texinfo_image_uri_base https:/file%2B.vscode-resource.vscode-cdn.net/Users/hsorensen/github/gccpl1/docs/pl1-ref/ -c EXTRA_HEAD <script>window.addEventListener('message', event => {const message = event.data;switch (message.command) {case 'goto':window.location.hash = message.value;history.pushState('', '', window.location.pathname);break;}})</script> /Users/hsorensen/github/gccpl1/docs/pl1-ref/gpli-programming-ref.texi

Content of html-preview:
use strict;
sub vscode_convert_image_uri
{
    my($self,$cmdname,$command,$args)=@_;
    my$filename=$args->[0]->{'monospacetext'};
    my$prefix=(defined($filename)&&rindex($filename,'http://',0)==-1&&rindex($filename,'https://',0)==-1)?$self->{'parser'}->{'values'}->{'__vscode_texinfo_image_uri_base'}:undef;
    $self->set_conf('IMAGE_LINK_PREFIX',$prefix);
    return&{$self->default_commands_conversion($cmdname)}(@_);
}
texinfo_register_command_formatting('image',\&vscode_convert_image_uri);
1;