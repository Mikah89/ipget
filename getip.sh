#! /bin/bash

FILENAME="lastip.out"
MAILRCV=""

CURRIP=$(curl --silent http://ipecho.net/plain)
OLDIP=$(tail $FILENAME)

if [ "$CURRIP" != "$OLDIP" ]
then
    ## sendmail then update file with new ip (or reverse)
    echo "IP changed, Updating..."
    echo $CURRIP
    echo $CURRIP > $FILENAME
    echo $CURRIP | mail -s "New IP detected" $MAILRCV
else
    echo "No IP change"
    echo $CURRIP
fi
