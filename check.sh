#!/bin/bash
# This is a script meant to let us test NRPE
# Plugins that we write

status="0"                                  # Change the status to test different alert states

if [ $status == "0" ]; then
    echo "STATUS:up"
    exit 0;
    
else
   echo "STATUS:down"
   exit 1;
fi
