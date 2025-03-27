#!/bin/bash

docker run --rm -v ./out:/mnt -it $(docker build -q .)