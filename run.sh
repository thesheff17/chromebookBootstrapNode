#!/bin/bash

docker rmi thesheff17/chromebookbootstrapbode:latest
time docker build . -t thesheff17/chromebookbootstrapbode:latest

echo "run.sh completed"
