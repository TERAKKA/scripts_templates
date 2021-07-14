#!/bin/bash

HOST="10.11.12.13"
PORT="1234"

echo -e '\035\nquit' | telnet $HOST $PORT
if [ $? -eq 0 ]; then
	echo "1" #успех
else
	echo "0" #провал
fi
exit 0