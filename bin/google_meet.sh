#!/bin/bash

#DATETIME=`date +%Y%m%d.%H%M`
#DATETIME=`date +%m-%d-%Y.%H:%M`
exec >> /tmp/meet.log  2>&1
echo $DATETIME
# check if the event is a Google or Zoom meet. Search for links in the event 
CALENDARS='Personal Calendar,Hiren Hindocha,Calendar'

count_gm=$(/usr/local/bin/icalBuddy -n -ic "$CALENDARS" --limitItems 1\
          'eventsToday' | grep -c 'meet.google.com')

if [ $count_gm gt 0 ];
then
    echo "Turning off Music, turning off Dragon and Jumping to Google Meet"

    # Turn off the music
    $HOME/scripts/sonos.py --action pause --device 'Sonos Move'

    # I've forgotten to turn off Dragon before , so let's turn it off
    osascript -e 'tell application "Dragon" to set listening to false'

    osascript -e 'tell application "Keyboard Maestro Engine" to do script "Jump to Google Meet"'
else
    echo "Do nothing, we don't have a Google Meet"
fi 

