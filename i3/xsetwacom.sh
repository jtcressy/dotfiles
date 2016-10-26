#!/bin/bash
DEVICE=$(xsetwacom list | awk '{print $1,$2,$3,$4,$5,$6,$7}' | grep stylus)
PRIMARYOUTPUT=$(xrandr | grep primary | awk '{print $1}')
echo "Device: " $(xsetwacom list | awk '{print $1,$2,$3,$4,$5,$6,$7}' | grep stylus)
echo "Primary Display: " $PRIMARYOUTPUT
xsetwacom --set "$DEVICE" MapToOutput $PRIMARYOUTPUT
xsetwacom --set "$DEVICE" ResetArea
AREA=$(xsetwacom --get "$DEVICE" Area)
echo "Default Active Area: " $AREA
NEWAREA="1447 1447 8813 6316"
echo "New Active Area: " $NEWAREA
xsetwacom --set "$DEVICE" Area $NEWAREA