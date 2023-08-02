#!/bin/bash

SOURCE_PATH=/home/bjo/deployment

APP_PATH=${SOURCE_PATH}/search
DATA_PATH=${APP_PATH}/data

cp ${DATA_PATH}/database.pkl ${DATA_PATH}/database.pkl.bak
docker run --user 0 -v ${APP_PATH}:/app -it deployment-search bash -c "cd /app && python update.py" && docker restart search && echo "Successfuly updated search" || (
cp ${DATA_PATH}/database.pkl.bak ${DATA_PATH}/database.pkl
)
