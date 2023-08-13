#!/bin/bash

SOURCE_PATH=/home/bjo/deployment

APP_PATH=${SOURCE_PATH}/search
DATA_PATH=${APP_PATH}/data
chown bjo:bjo ${DATA_PATH}/*
cp ${DATA_PATH}/database.pkl ${DATA_PATH}/database.pkl.bak
docker run --user 0 -v ${APP_PATH}:/app -i deployment-search bash -c "cd /app && python update.py" && docker restart search && echo "Successfully updated search" || (
cp ${DATA_PATH}/database.pkl.bak ${DATA_PATH}/database.pkl
chown bjo:bjo ${DATA_PATH}/*
)
