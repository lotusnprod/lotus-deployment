#!/bin/bash

SOURCE_PATH=/home/bjo/deployment
MOL_APP_PATH=${SOURCE_PATH}/mol_search
MOL_DATA_PATH=${MOL_APP_PATH}/data

TEXT_APP_PATH=${SOURCE_PATH}/text_search
TEXT_DATA_PATH=${TEXT_APP_PATH}/data


cp ${MOL_DATA_PATH}/smiles.csv ${MOL_DATA_PATH}/smiles.csv.bak
cp ${MOL_DATA_PATH}/structure_fps.pkl ${MOL_DATA_PATH}/structure_fps.pkl.bak
docker run --user 0 -v ${MOL_APP_PATH}:/app -it mol_search bash -c "cd /app && python generate_database.py" && docker restart mol_search && echo "Successfuly updated mol_search" || (
cp ${MOL_DATA_PATH}/smiles.csv.bak ${MOL_DATA_PATH}/smiles.csv
cp ${MOL_DATA_PATH}/structure_fps.pkl.bak ${MOL_DATA_PATH}/structure_fps.pkl
)


cp ${TEXT_DATA_PATH}/couples.csv ${TEXT_DATA_PATH}/couples.csv.bak
cp ${TEXT_DATA_PATH}/taxa.csv ${TEXT_DATA_PATH}/taxa.csv.bak
cp ${TEXT_DATA_PATH}/smiles.csv ${TEXT_DATA_PATH}/smiles.csv.bak
docker run --user 0 -v ${TEXT_APP_PATH}:/app -it text_search bash -c "cd /app && python download_couples.py && python download_smiles.py && python download_taxa.py" && docker restart text_search && echo "Successfuly updated text_search" || (
cp ${TEXT_DATA_PATH}/couples.csv.bak ${TEXT_DATA_PATH}/couples.csv
cp ${TEXT_DATA_PATH}/taxa.csv.bak ${TEXT_DATA_PATH}/taxa.csv
cp ${TEXT_DATA_PATH}/smiles.csv.bak ${TEXT_DATA_PATH}/smiles.csv
)


