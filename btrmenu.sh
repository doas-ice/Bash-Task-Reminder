#!/usr/bin/env sh
bash btrserver.sh >> btrserver.log 2>&1 &

while(true)
do
    echo "Select an item: "
    echo "1. create a new task"
    echo "2. view all tasks"
    echo "3. delete a task"
    echo "4. modify a task"
    echo "5. clear all tasks"
    echo "6. exit the program"
    pm=$(zenity --list --title="Bash Task Reminder" --text="Select an item: " --width=640 --height=480 --radiolist --column=\# --column=Num --column=Description --print-column=2 --hide-column 2 -- 1 1 "Create a new task" 2 2 "View existing tasks" 3 3 "Delete an existing task" 4 4 "Modify an existing task" 5 5 "Clear all tasks" 6 6 "Exit the program")
    case $pm in
        1)
            bash btrcreator.sh
            ;;
        2)
            echo view
            for folder in $(pwd)/*/;do echo "$(cat ${folder}tskowner)"; echo "$(cat ${folder}tskdate)"; echo "$(cat ${folder}tsktime)"; echo "$(cat ${folder}tskdesc)"; done | zenity --title="Bash Task Reminder" --list --text="View All Tasks" --width=640 --height=480 --column=Creator --column=date --column=Time --column=Description 

            for folder in $(pwd)/*/
            do
                tskowner=$(cat ${folder}tskowner)
                tsktime=$(cat ${folder}tsktime)
                tskdate=$(cat ${folder}tskdate)
                tskdesc=$(cat ${folder}tskdesc)
                echo "Task ID: "$(echo $folder | tr -dc '0-9')
                echo "Task Due: $tskdate $tsktime"
                echo "Task Creator: $tskowner"
                echo "Task Description: $tskdesc"
                echo
            done
            ;;
        3)
            echo delete
            dl=$(for folder in $(pwd)/*/;do echo "$(echo $folder | tr -dc '0-9')"; echo "$(echo $folder | tr -dc '0-9')"; echo "$(cat ${folder}tskowner)"; echo "$(cat ${folder}tskdate)"; echo "$(cat ${folder}tsktime)"; echo "$(cat ${folder}tskdesc)"; done | zenity --title="Bash Task Reminder" --list --text="Delete an existing task" --width=640 --height=480 --radiolist --column=\# --column=i --column=Creator --column=date --column=Time --column=Description --hide-column=2 --print-column=2)
            for folder in $(pwd)/*/
            do
                tskowner=$(cat ${folder}tskowner)
                tsktime=$(cat ${folder}tsktime)
                tskdate=$(cat ${folder}tskdate)
                tskdesc=$(cat ${folder}tskdesc)
                echo "Task ID: "$(echo $folder | tr -dc '0-9')
                echo "Task Due: $tskdate $tsktime"
                echo "Task Creator: $tskowner"
                echo "Task Description: $tskdesc"
                echo
            done
            if [ -d task$dl ]
            then
                if zenity --question --title="Bash Task Reminder" --text="Are you sure you want to delete this task?" --ok-label="Delete" --cancel-label="Don't Delete"
                then
                    echo Danger
                    echo rm -r task$dl
                    rm -r task$dl
                else
                    echo Safe
                fi
            else
                echo "Invalid Task ID"
            fi


            ;;
        4)
            echo modify
            md=$(for folder in $(pwd)/*/;do echo "$(echo $folder | tr -dc '0-9')"; echo "$(echo $folder | tr -dc '0-9')"; echo "$(cat ${folder}tskowner)"; echo "$(cat ${folder}tskdate)"; echo "$(cat ${folder}tsktime)"; echo "$(cat ${folder}tskdesc)"; done | zenity --title="Bash Task Reminder" --list --text="Modify an existing task" --width=640 --height=480 --radiolist --column=\# --column=i --column=Creator --column=date --column=Time --column=Description --hide-column=2 --print-column=2)
            for folder in $(pwd)/*/
            do
                tskowner=$(cat ${folder}tskowner)
                tsktime=$(cat ${folder}tsktime)
                tskdate=$(cat ${folder}tskdate)
                tskdesc=$(cat ${folder}tskdesc)
                echo "Task ID: "$(echo $folder | tr -dc '0-9')
                echo "Task Due: $tskdate $tsktime"
                echo "Task Creator: $tskowner"
                echo "Task Description: $tskdesc"
                echo
            done
            if [ -d task$md ]
            then
                tskowner=$(zenity --title="Bash Task Reminder" --width=640 --height=480 --entry --text="Enter your name: $(cat task$md/tskowner)" --entry-text " "); 
                rm task$md/tskowner
                echo -n $tskowner >> task$md/tskowner

                tskdate=$(zenity --title="Bash Task Reminder" --width=640 --height=480 --calendar --text "Choose your event's date: $(cat task$md/tskdate)" --date-format=%Y-%m-%d);
                rm task$md/tskdate
                echo -n $tskdate >> task$md/tskdate

                tsktime=$(zenity --width=640 --height=480 --entry --height=100 \
                --title "Bash Task Reminder" \
                --text "Input Time (24H format HH:mm): " \
                --entry-text "$(cat task$md/tsktime)");
                rm task$md/tsktime
                echo -n $tsktime >> task$md/tsktime

                tskdesc=$(zenity --width=640 --height=480 --text-info --title "Bash Task Reminder: Event Description" --filename=task$md/tskdesc --editable);
                rm task$md/tskdesc
                echo -n $tskdesc >> task$md/tskdesc
            else
                echo "Invalid Task ID"
            fi
            ;;
        5)
            if zenity --question --title="Bash Task Reminder" --text="Are you sure you want to delete all existing tasks?" --ok-label="Delete" --cancel-label="Don't Delete"
            then
                echo Danger
                rm -r task*
                echo 1 > taskindex
            else
                echo Safe
            fi
            ;;
        6)
            break
            ;;
        *)
            echo none
            break
            ;;
    esac
done
