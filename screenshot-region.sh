MAXNUM=0
cd '/home/rowan/'
for i in screenshot*.png;
    do echo $i;
    NUM=$(echo $i | tr -dc '0-9');
    if [ $NUM -ge $MAXNUM ]
      then
        MAXNUM=$NUM;
    fi;
done;
NEWNUM=$(($MAXNUM+1))
import "/home/rowan/screenshot$NEWNUM.png"
