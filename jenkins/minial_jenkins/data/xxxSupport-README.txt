# TODO Must not be in the context of Dockerfile (image building)! After
# Building the image is configured anyway and the distoro can't change
# IMPROVEMENT: Use these sources and ideas as an overall Docker image
# building "environemnt".

In each of these directories some base image dependent configuration stuff 
can be placed.

All of them will be copied into the image under /usr/local/share/xxxSupport. 
From there the content of the matching system can be moved over to /usr/local/bin/
and be used.

The script xxxSupport.sh is used to evaluate the current running system and
return the right directory. This directory can then be used to source in 
or copy/execute scripts.

CONVENTION:
One file has to exist in ALL xxxSupport directories. It's the functions.sh
script. This script must contain the following functions:
    - configShell   # To configure shell behaviours like history controll, 
                    # colloring and prompt.    
    - setTimeZone   # Configures the timezone.