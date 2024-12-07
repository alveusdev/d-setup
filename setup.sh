#!/bin/bash

ACCENT='\033[1;32m'
NC='\033[0m' # No Color

# Update submodules
echo -e "${ACCENT}Updating submodules${NC}\n"
git pull --recurse-submodules
git submodule update --init --recursive

# Setup compilers and activate DMD
echo -e "\n${ACCENT}Setting up compilers${NC}\n"

curl -fsS https://dlang.org/install.sh | bash -s dmd
curl -fsS https://dlang.org/install.sh | bash -s ldc

DMDDIR=$(ls -d ~/dlang/dmd-*/ | head -1)

echo -e "\n${ACCENT}Activating DMD with ${DMDDIR}${NC}\n"
source $DMDDIR/activate
dmd --version

# Build tools

mkdir -p ./tools

echo -e "\n${ACCENT}Building Tools${NC}"
echo -e "\n${ACCENT} - DFormat${NC}\n"
cd dformat
make
mv -f ./bin/dfmt ../tools/dfmt

echo -e "\n${ACCENT} - D-Scanner${NC}\n"
cd ../dscanner
make
mv -f ./bin/dscanner ../tools/dscanner

echo -e "\n${ACCENT} - DCD${NC}\n"
cd ../dcd
make
mv -f ./bin/dcd-client ../tools/dcd-client
mv -f ./bin/dcd-server ../tools/dcd-server

echo -e "\n${ACCENT}Complete"
