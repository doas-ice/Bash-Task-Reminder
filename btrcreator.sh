#!/usr/bin/env bash

if [ -f taskindex ]
then
	ts=$(cat taskindex)
else
	ts=1
fi

mkdir task$ts
tskowner=$(zenity --title="Bash Task Reminder" --width=640 --height=480 --entry --text="Enter your name:" --entry-text " "); 
echo -n $tskowner >> task$ts/tskowner

tskdate=$(zenity --title="Bash Task Reminder" --width=640 --height=480 --calendar --text "Choose your event's date." --date-format=%Y-%m-%d);
echo -n $tskdate >> task$ts/tskdate

tsktime=$(zenity --width=640 --height=480 --entry --height=100 \
--title "Bash Task Reminder" \
--text "Input Time (24H format HH:mm): " \
--entry-text "09:30");
echo -n $tsktime >> task$ts/tsktime

tskdesc=$(zenity --title="Bash Task Reminder: Event Description" --width=640 --height=480 --text-info --editable);
echo -n $tskdesc >> task$ts/tskdesc
ts=$(($ts+1))
rm taskindex
echo -n $ts >> taskindex
