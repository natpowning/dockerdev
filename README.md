# dockerdev

## Description
Docker image for debug and development including GUI tools executed via X11.
* Includes SSH server to allow execution of X11 GUI's over a tunnel when the container cannot initiate contact with the display host.


## X11 Server Setup
If you're running a GUI on Linux you are most likely already running an X11 server.  OS X and Windows require additional software to support X11...

### OS X
XQuartz is a good solution: https://www.xquartz.org

### Windows
Several X11 solutions exist, Xming seems to do the job fine: https://sourceforge.net/projects/xming/


## Use

### Command-line only tools
If you're not executing GUI tools the command line you can launch a container and obtain a shell directly via Docker using the command: `docker run -it --rm --entrypoint bash natpowning/dockerdev`

### GUI tools
1. Launch container with sshd exposed on port 2222: `docker run -it --rm -p 2222:22 natpowning/dockerdev`  Note the root password is output which is used in the next step.
2. Open a shell on the container via ssh (replace HOSTNAME with a manager in your swarm or localhost if running the container locally): `ssh -XY -p 2222 root@HOSTNAME`
3. On the resulting command line execute the tool.  You can follow the command with & to put it in the background allowing execution of multiple tools.


## Included Tools
* Eclipse IDE
* Visual Studio Code
* Git
* vim
* Google Chrome

