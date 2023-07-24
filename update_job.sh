#!/bin/bash

cp /home/bjo/molecule_search/app/data/smiles.csv /home/bjo/molecule_search/app/data/smiles.csv.bak
cp /home/bjo/molecule_search/app/data/structure_fps.pkl /home/bjo/molecule_search/app/data/structure_fps.pkl.bak
docker run --user 0 -v /home/bjo/molecule_search/app:/app -it mol_search bash -c "cd /app && python generate_database.py" && docker restart mol_search && echo "Successfuly updated" || (
cp /home/bjo/molecule_search/app/data/smiles.csv.bak /home/bjo/molecule_search/app/data/smiles.csv
cp /home/bjo/molecule_search/app/data/structure_fps.pkl.bak /home/bjo/molecule_search/app/data/structure_fps.pkl
)
