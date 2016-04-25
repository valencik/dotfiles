#!/bin/bash -e
#http://sqar.blogspot.de/2014/10/installing-yosemite-in-virtualbox.html
# First argument must point to an OS X Installer app
# Second argument is the desired name of the VM

#Define mesage output types and colours
ERROR="$(tput setaf 1)ERROR:$(tput sgr 0)"
SUCCESS="$(tput setaf 2)SUCCESS:$(tput sgr 0)"

# Check command line arguments
if [ "$#" -lt 2 ]; then
  echo "${ERROR} Usage: $0 /Applications/Install\ OS\ X\ Yosemite.app Yosemite-Sandbox"
  exit 1
fi

# Setup variables 
installer=$1
vmname=$2
if [ ! -d "$installer" ]; then
  echo "${ERROR} Could not find $installer"
fi

# Fail if not on Darwin kernel
if [ "$(uname)" != "Darwin" ]; then 
  echo "${ERROR} This script was designed for Mac OS X only."
fi

# Check for ruby gem iesd
if [ -z "$(which iesd)" ]; then 
  echo "${ERROR} $0 depends on Ruby gem 'iesd'."
  echo "${ERROR} Do you want to run 'gem install iesd' now? [y/n] "
  read answer
  if [ "$answer" == "y" ]; then
    gem install iesd
  else
    echo "${ERROR} Please install iesd and run $0 again."
    exit 1 
  fi
fi

# Check for VirtualBox
if [ -z "$(which VBoxManage)" ]; then 
  echo "${ERROR} $0 depends on VirtualBox"
  echo "${ERROR} Do you want to run install VirtualBox now via brew cask? [y/n] "
  read answer
  if [ "$answer" == "y" ]; then
    brew cask update
    brew cask install virtualbox
  else
    echo "${ERROR} Please install VirtualBox and run $0 again."
    exit 1 
  fi
fi

# Register the virtual machine
# http://www.virtualbox.org/manual/ch08.html
VBoxManage createvm --name "$vmname" --ostype "MacOS109_64" --register

# Determine destination locations
vmdir="$(dirname "$(VBoxManage showvminfo "$vmname" |\
                    grep "Config file:" | cut -d ":" -f 2 | sed 's/^ *//')")"
vmiso="$vmdir""$vmname"VB.iso  
vmvdi="$vmdir""$vmname"VB.vdi  

# Mount the installer image  
hdiutil attach "$installer"/Contents/SharedSupport/InstallESD.dmg -noverify -nobrowse -mountpoint /Volumes/install_app  
  
# Convert the boot image to a sparse bundle  
hdiutil convert /Volumes/install_app/BaseSystem.dmg -format UDSP -o /tmp/"$vmname"  
  
# Increase the sparse bundle capacity to accommodate the packages  
hdiutil resize -size 8g /tmp/"$vmname".sparseimage  
  
# Mount the sparse bundle for package addition  
hdiutil attach /tmp/"$vmname".sparseimage -noverify -nobrowse -mountpoint /Volumes/install_build  
  
# Remove Package link and replace with actual files  
rm /Volumes/install_build/System/Installation/Packages  
cp -rp /Volumes/install_app/Packages /Volumes/install_build/System/Installation/  
  
# Copy Base System  
cp -rp /Volumes/install_app/BaseSystem.dmg /Volumes/install_build/  
cp -rp /Volumes/install_app/BaseSystem.chunklist /Volumes/install_build/  
  
# Unmount the installer image and sparse bundle
hdiutil detach /Volumes/install_app  
hdiutil detach /Volumes/install_build  
  
# Resize the partition in the sparse bundle to remove any free space  
hdiutil resize -size \
"$(hdiutil resize -limits /tmp/"$vmname".sparseimage | tail -n 1 | awk '{ print $1 }')"b /tmp/"$vmname".sparseimage  
  
# Convert the sparse bundle to ISO/CD master  
hdiutil convert /tmp/"$vmname".sparseimage -format UDTO -o /tmp/"$vmname"  
  
# Cleanup /tmp and move iso to dest
rm /tmp/"$vmname".sparseimage  
mv /tmp/"$vmname".cdr "$vmiso"

# Create the virtual machine disk
# https://gist.github.com/frdmn/de12c894a385bc8e6bff
# Create virtual machine disk
VBoxManage createhd --filename "$vmvdi" --size 20480
echo "${SUCCESS} Created $vmvdi"

# Attach ISO and VDI
VBoxManage storagectl "$vmname" --name "SATA" --add sata --controller IntelAHCI
VBoxManage storageattach "$vmname" --storagectl "SATA" --port 0 --device 0 --type hdd --medium "$vmvdi"
VBoxManage storageattach "$vmname" --storagectl "SATA" --port 1 --device 0 --type dvddrive --medium "$vmiso"

# Configure VM 
VBoxManage modifyvm "$vmname" --ioapic on --firmware efi --boot1 dvd --boot2 disk
VBoxManage modifyvm "$vmname" --memory 2048 --vram 128 --mouse usb --keyboard usb
VBoxManage modifyvm "$vmname" --cpuidset 1 000206a7 02100800 1fbae3bf bfebfbff
#VBoxManage modifyvm "$vmname" --nic1 bridged --bridgeadapter1 eth0

#Start the VM
echo "${SUCCESS} Starting $vmname..."
VBoxManage startvm "$vmname"
