#!/bin/bash
while true; do
    pactl get-sink-volume @DEFAULT_SINK@ | awk '{print "VOL " $5}'
    sleep 1
done
