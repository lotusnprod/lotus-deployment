#!/bin/bash

SOURCE_PATH=/home/bjo/deployment

APP_PATH=${SOURCE_PATH}/search
DATA_PATH=${APP_PATH}/data

cp ${DATA_PATH}/couples.csv ${DATA_PATH}/couples.csv.bak
cp ${DATA_PATH}/taxa.csv ${DATA_PATH}/taxa.csv.bak
cp ${DATA_PATH}/smiles.csv ${DATA_PATH}/smiles.csv.bak
cp ${DATA_PATH}/structure_fps.pkl ${DATA_PATH}/structure_fps.pkl.bak
docker run --user 0 -v ${APP_PATH}:/app -it deployment-search bash -c "cd /app && python update.py" && docker restart search && echo "Successfuly updated search" || (
cp ${DATA_PATH}/couples.csv.bak ${DATA_PATH}/couples.csv
cp ${DATA_PATH}/taxa.csv.bak ${DATA_PATH}/taxa.csv
cp ${DATA_PATH}/smiles.csv.bak ${DATA_PATH}/smiles.csv
cp ${DATA_PATH}/structure_fps.pkl.bak ${DATA_PATH}/structure_fps.pkl
)
