::#
::# Wrapper for makeinfo for the texinfo VS Code extension. Set path to makeinfo.cmd
::# Build docker image as 
::# docker build -f _docker/dockerfile_texinfo -t itsme/texinfo .
::#
echo off
SET IMAGE=itsme/texinfo

::# TODO: Derive USR and PRJ from environment
SET USR0=c:\Users\ChatAI
SET USR1=e:\Users\ChatAI
SET USR=/Users/ChatAI
SET PRJ=gccpl1

SET V1=%USR0%/.vscode/extensions/cismonx.texinfo-0.2.4:%USR%/.vscode/extensions/cismonx.texinfo-0.2.4
SET V2=%USR1%/%PRJ%:%USR%/%PRJ%
SET W=%USR%/%PRJ%

::echo " makeinfo cmd file %*"

::# All arguments as array
::args=("$@")
::# Get filename as the last argument
::fn_ix=$#-1 
::FILENAME=${args[$fn_ix]}
::FILENAME is relative to volume inside container
SET FILENAME=src-gcc/gcc/doc/options.texi

::# Start makeinfo without -D __vscode_texinfo_image_uri_base argument.
docker run --rm --hostname texinfo -v %V1% -v %V2% --workdir %W% -t %IMAGE% makeinfo -o- --no-split --html --error-limit=100 --init-file=%USR%/.vscode/extensions/cismonx.texinfo-0.2.4/ext/html-preview.pm -c EXTRA_HEAD="<script>window.addEventListener('message', event => {const message = event.data;switch (message.command) {case 'goto':window.location.hash = message.value;history.pushState('', '', window.location.pathname);break;}})</script>" %FILENAME%
exit /b 0

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