#!/bin/bash
# este script lee user1, pwd1, user2, pwd2 desde accounts.motociclist
# y trae los correos.
# hacked from https://gist.github.com/onlime/4bc4514e835d7c4d685f

#####Variables globales#####
ACCOUNTS=accounts.list
EXTRALOG=sync.log
TSFORMAT="%Y-%m-%d %H:%M:%S"
SRCHOST=200.69.222.92
DSTHOST=localhost
#############################

grep -ve '^#.*' $ACCOUNTS | while read SRCUSER SRCPW DSTUSER DSTPW
do
    MESSAGE="[`date +"$TSFORMAT"`] synchronizing $SRCUSER:$SRCPW to $DSTUSER:$DSTPW"
    echo $MESSAGE
    echo $MESSAGE >> $EXTRALOG
    imapsync \
    --keepalive1 --keepalive2 \
    --nossl1 --nossl2 \
    --tmpdir /var/tmp --noreleasecheck \
    --dry --justfoldersizes \
    --host1 $SRCHOST --user1 $SRCUSER --password1 $SRCPW \
    --host2 $DSTHOST --user2 $DSTUSER --password2 $DSTPW
done
