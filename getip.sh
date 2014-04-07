#! /bin/bash

FILENAME="lastip.out"
MAILRCV=""

OLDIP=$(tail $FILENAME)
CURRIP=$(curl --silent http://ipecho.net/plain)

if [ $? -ne 0 ]
then
    echo "Failed to obtain current ip."
    exit -1
fi

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
