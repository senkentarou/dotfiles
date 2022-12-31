#!/bin/bash

# General Setting
LOG='/dev/null'
COLOR_PRECAP='\033['
COLOR_AFTCAP='m'
COLOR_RED="${COLOR_PRECAP}31${COLOR_AFTCAP}"
COLOR_YELLOW="${COLOR_PRECAP}33${COLOR_AFTCAP}"
COLOR_GREEN="${COLOR_PRECAP}32${COLOR_AFTCAP}"
COLOR_CYAN="${COLOR_PRECAP}36${COLOR_AFTCAP}"
COLOR_OFF="${COLOR_PRECAP}${COLOR_AFTCAP}"

echo_normal() {
	echo "* ${1}" | tee -a ${LOG}
}

echo_error() {
	echo "$COLOR_RED * ERROR: $1 $COLOR_OFF" | tee -a $LOG
}

echo_warning() {
	echo "$COLOR_YELLOW * WARNING: $1 $COLOR_OFF" | tee -a $LOG
}

echo_success() {
	echo "$COLOR_GREEN * SUCCESS: $1 $COLOR_OFF" | tee -a $LOG
}

echo_info() {
	echo "$COLOR_CYAN * INFOMATION: $1 $COLOR_OFF" | tee -a $LOG
}

is_exist_command() {
	which "$1" >/dev/null 2>&1
	return $?
}
