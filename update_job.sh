#!/bin/bash

SOURCE_PATH=/home/bjo/deployment

TEXT_APP_PATH=${SOURCE_PATH}/text_search
TEXT_DATA_PATH=${TEXT_APP_PATH}/data

cp ${TEXT_DATA_PATH}/couples.csv ${TEXT_DATA_PATH}/couples.csv.bak
cp ${TEXT_DATA_PATH}/taxa.csv ${TEXT_DATA_PATH}/taxa.csv.bak
cp ${TEXT_DATA_PATH}/smiles.csv ${TEXT_DATA_PATH}/smiles.csv.bak
cp ${TEXT_DATA_PATH}/structure_fps.pkl ${TEXT_DATA_PATH}/structure_fps.pkl.bak
docker run --user 0 -v ${TEXT_APP_PATH}:/app -it deployment-text_search bash -c "cd /app && python download_couples.py && python download_smiles.py && python download_taxa.py && python generate_database.py" && docker restart text_search && echo "Successfuly updated text_search" || (
cp ${TEXT_DATA_PATH}/couples.csv.bak ${TEXT_DATA_PATH}/couples.csv
cp ${TEXT_DATA_PATH}/taxa.csv.bak ${TEXT_DATA_PATH}/taxa.csv
cp ${TEXT_DATA_PATH}/smiles.csv.bak ${TEXT_DATA_PATH}/smiles.csv
cp ${TEXT_DATA_PATH}/structure_fps.pkl.bak ${TEXT_DATA_PATH}/structure_fps.pkl
)
