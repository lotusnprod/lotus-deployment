#!/bin/bash

SOURCE_PATH=/home/bjo/deployment
MOL_APP_PATH=${SOURCE_PATH}/mol_search
MOL_DATA_PATH=${MOL_APP_PATH}/data

cp ${MOL_DATA_PATH}/smiles.csv ${MOL_DATA_PATH}/smiles.csv.bak
cp ${MOL_DATA_PATH}/structure_fps.pkl ${MOL_DATA_PATH}/structure_fps.pkl.bak
docker run --user 0 -v ${MOL_APP_PATH}:/app -it mol_search bash -c "cd /app && python generate_database.py" && docker restart mol_search && echo "Successfuly updated" || (
cp ${MOL_DATA_PATH}/smiles.csv.bak ${MOL_DATA_PATH}/smiles.csv
cp ${MOL_DATA_PATH}/structure_fps.pkl.bak ${MOL_DATA_PATH}/structure_fps.pkl
)
