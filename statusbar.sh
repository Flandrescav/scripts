#! /bin/bash

print_men() {
    mem_total=$(cat /proc/meminfo | grep "MemTotal:"|awk '{print $2}')
    mem_free=$(cat /proc/meminfo | grep "MemFree:"|awk '{print $2}')
    mem_buffers=$(cat /proc/meminfo | grep "Buffers:"|awk '{print $2}')
    mem_cached=$(cat /proc/meminfo | grep -w "Cached:"|awk '{print $2}')
    men_usage_rate=$(((mem_total - mem_free - mem_buffers - mem_cached) * 100 / mem_total))
    mem_text=$(echo $men_usage_rate | awk '{printf "%02d%", $1}')
    echo " $mem_text "
}

print_cpu() {
    cpu_text=$(top -n 1 -b | sed -n '3p' | awk '{printf "%02d%", 100 - $8}')
    echo "閭 $cpu_text "
}

print_vol() {
    sink=$(pactl info | grep 'Default Sink' | awk '{print $3}')
    volunmuted=$(pactl list sinks | grep $sink -A 6 | sed -n '7p' | grep 'Mute: no')
    vol_text=$(pactl list sinks | grep $sink -A 7 | sed -n '8p' | awk '{printf int($5)}')
    echo "墳 $vol_text"
}

print_date() {
    time_text="$(date '+%Y/%m/%d %H:%M')"
    echo " $time_text"
}

print_bat() {
    bat_text=$(acpi -b | sed 2d | awk '{print $4}' | grep -Eo "[0-9]+")
    echo  "$(get_print_batstatus) $bat_text"
}

get_print_batstatus() {
    if   [ "$bat_text" -ge 95 ]; then echo "";
    elif [ "$bat_text" -ge 90 ]; then echo "";
    elif [ "$bat_text" -ge 80 ]; then echo "";
    elif [ "$bat_text" -ge 70 ]; then echo "";
    elif [ "$bat_text" -ge 60 ]; then echo "";
    elif [ "$bat_text" -ge 50 ]; then echo "";
    elif [ "$bat_text" -ge 40 ]; then echo "";
    elif [ "$bat_text" -ge 30 ]; then echo "";
    elif [ "$bat_text" -ge 20 ]; then echo "";
    elif [ "$bat_text" -ge 10 ]; then echo "";
    fi
}

xsetroot -name "$(print_men)$(print_cpu)$(print_vol) $(print_bat) $(print_date)"
