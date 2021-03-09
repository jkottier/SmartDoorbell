#!/bin/sh
days=$1
action=$2

function echo_usage() {
   echo "Usage: cleanup requires two paramters: days(number) and action(list or delete)"
   echo "       bash example: cleanup.sh 31 list"
   echo "       browser example: cleanup.cgi?days=31&action=list"
}

if [[ -z "${days##*[!0-9]*}" ]] || [[ $days -lt 1 ]] || [[ $action != "list" && $action != "delete" ]]
then 
    echo_usage && exit 1
else 
    #substract 1 day
    days_calc=$(($days-1))

    # find based on calendar dates, where 1 day = older than yesterday
    files_older_than=$(/mnt/mmc01/bin/busybox find /mnt/mmc01/SDT/*/record/*/*/ -mmin +$(($(($days_calc*24*60))+$(($(($(date +%s)-$(date -d"$(date +%Y-%m-%d) 00:00:00" +%s)))/60)))) -type d -prune)
    if [ -z "${files_older_than}" ]
    then
        echo "No files found older than $days days"
        exit 1
    fi

    # determine how much there is to cleanup
    cleanup_space=$(/mnt/mmc01/bin/busybox du -ch $files_older_than | grep total | cut -f1)
    echo "Size of the files found older than ${days} day(s): $cleanup_space"

    case $action in
        delete)
            echo "The following files are older than ${days} day(s) and have been deleted:"
            for i in ${files_older_than}
            do
                echo "$i"
                rm -rf $i
            done
        ;;
        list)
            echo "The following files are older than ${days} day(s):"
            for i in ${files_older_than};do echo $i; done
        ;;
        *)
            echo "Invalid action received: $action"
        ;;
    esac
fi
