# SETUP REHL SERVER WITH GUI AND VNC SERVER
Here are the steps taken to set-up a VM with REHL 9 GUI to be connected through a VNC client.


## Install REHL 9 SERVER WITH GUI

1. update REHL ```sudo dnf update -y```
2. install GUI components ```sudo dnf groupinstall "Server with GUI" -y```
3. set the GUI as the default option ```sudo systemctl set-default graphical.target```

## Install TigerVNC 

1. install TigerVNC ```sudo dnf install tigervnc-server -y```
2. configure TigerVNC ```sudo cp /usr/lib/systemd/system/vncserver@.service /etc/systemd/system/vncserver@:1.service```
3. add user ```sudo vim /etc/tigervnc/vncserver.users``` user **```:1=mmetwalli```**
4. set the passwrod ```vncpasswd```
5. configure gnome ```echo gnome-session > ~/.session```
6. set-up the sessions ```vim ~/.vnc/config```
```
session=gnome
securitytypes=vncauth,tlsvnc
geometry=1920x1080
```
7. start the service ```sudo systemctl start vncserver@:1.service```

## Install Nvidia Drivers

1. Enable the RHEL 9 CodeReady Builder package repository:

```bash
sudo subscription-manager repos --enable codeready-builder-for-rhel-9-$(uname -i)-rpms
```
2. Install the epel-release package
```bash
sudo dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
```
3. Install the necessary build tools and libraries required for compiling Nvidia kernel modules:
```bash
sudo dnf install -y kernel-devel-$(uname -r) kernel-headers-$(uname -r) gcc make dkms acpid libglvnd-glx libglvnd-opengl libglvnd-devel pkgconfig
```
4. Add the official Nvidia CUDA package repository to your system:
```bash
sudo dnf config-manager --add-repo http://developer.download.nvidia.com/compute/cuda/repos/rhel9/$(uname -i)/cuda-rhel9.repo
```
5. Install the latest Nvidia GPU drivers
```bash
sudo dnf module install -y nvidia-driver:open-dkms
```
for specific version
```bash
sudo dnf module install -y nvidia-driver:535
```