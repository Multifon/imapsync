#!/bin/bash
# este script lee user1, pwd1, user2, pwd2 desde accounts.motociclist
# y borra correos más viejos de 30 días en ATM.
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
    MESSAGE="[`date +"$TSFORMAT"`] deleting at $SRCUSER"
    echo $MESSAGE
    echo $MESSAGE >> $EXTRALOG
    imapsync --nofoldersizes --nofoldersizesatend --no-modulesversion \
    --keepalive1 --keepalive2 \
    --nossl1 --nossl2 \
    --tmpdir /var/tmp --noreleasecheck \
    --host1 $SRCHOST --user1 $SRCUSER --password1 $SRCPW \
    --host2 $SRCHOST --user2 $SRCUSER --password2 $SRCPW \
    --delete1 --noexpungeaftereach --minage 730
done
