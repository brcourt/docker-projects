#! /bin/bash

trap "echo Caught SIGTERM; exit 0" SIGTERM
sleep 1000 & wait $!
