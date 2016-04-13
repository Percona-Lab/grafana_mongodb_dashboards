#!/bin/bash

for pidFile in example/tmp/*.pid; do
	if [ -f $pidFile ]; then
		pid=$(cat $pidFile)
		if [ ! -z $pid ] && [ -d /proc/$pid ]; then
			echo "Stopping PID $pid..."
			kill $pid 2>/dev/null
		fi
	fi
done
echo OK!
