#!/bin/bash
# script for mounting an SMB share for the firetv
# this script can be run in the following methods
	    # Directly from a script manager on the fireTV with Root Access
# This script can only mount 1 share, if you have multiple shares you wish to mount create multiple copies of this script - sorry for the inconvienience

#######################################################
#               Configuration Section                 #
#######################################################

#### FireTV Information ###
# These variables should reflect the settings of your fireTV

    ftvip='localhost'	#ip address of firetv
    adb_id='emulator-5554'	#adb device id, likely correct but verify with adb device (should reflect name of device from output)

#### Share information ####
# Below configure your share settings, this script only supports 1 share per script

    share_ip='192.168.1.10'		#ip address of samba server
    share_smb='myfiles'			#samba share name	    
    share_path='/mnt/obb/myfiles/'	#mount point for share, include trailing /, this directory should not exist and should remain in /mnt/obb/
    share_usn='myusername'			#username for share access
    share_pwd='password'		#password for share access


#######################################################
#               Script Functions                      #
#######################################################
function adb_connect {
    adb connect $ftvip
    sleep 3
}

function mount_share {
    adb -s $adb_id shell "su -c mkdir $share_path"
    adb -s $adb_id shell "su -c mount -o noperm,unc=\\\\\\\\\\\\\\\\$share_ip\\\\\\\\$share_smb,username=$share_usn,password=$share_pwd -t cifs none $share_path"
}

function adb_disconnect {
    adb disconnect
}


#######################################################
#               Main Code                             #
#######################################################
adb_connect
mount_share
adb_disconnect
