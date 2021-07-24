#!/bin/bash

set -x

export FFTW_DIR="$PREFIX/lib"

${PYTHON} -m pip install . -vv --install-option="-j${CPU_COUNT}"
${PYTHON} setup.py build_shared_clib -j${CPU_COUNT}

cp include/GalSim.h "$PREFIX/include"
cp -r include/galsim "$PREFIX/include"
cp -PR build/shared_clib/libgalsim* "$PREFIX/lib"

if [[ ${target_platform} == osx-* ]]; then
    lname=$(basename ${PREFIX}/lib/libgalsim.*.dylib)
    echo "changing id of ${lanem} w/ install_name_tool"

    install_name_tool -id "@rpath/${lname}" ${lname}
fi
