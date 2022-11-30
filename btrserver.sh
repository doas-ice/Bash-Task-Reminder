#!/usr/bin/env bash
bash killbtr.sh
echo $$ > btrserverpid
echo $(cat btrserverpid)
sleep 3s
while (true)
do

    for folder in $(pwd)/*/
    do
        datenow="`date '+%Y-%m-%d'`";
        timenow="`date '+%H:%M'`";
        tskowner=$(cat ${folder}tskowner)
        tsktime=$(cat ${folder}tsktime)
        tskdate=$(cat ${folder}tskdate)
        tskdesc=$(cat ${folder}tskdesc)
        echo "timenow: $timenow:$(date '+%S');"
        echo "datenow: $datenow;"
        echo "eventtime: $tsktime;"
        echo "eventdate: $tskdate;"
        if [ "$tsktime" = "$timenow" ] && [ "$tskdate" == "$datenow" ]
        then
            echo -n
            notify-send -e --app-name="Bash Task Reminder" "date: $tskdate $tsktime" "Reminder for: $tskowner\nDescription: $tskdesc"
            zenity --info --text "REMEMBER!!! $tskowner\nToday's date is $tskdate and you have an event at $tsktime\nEvent Description: $tskdesc "
            rm -r $folder
        fi
    done
    sleep 5s
done

