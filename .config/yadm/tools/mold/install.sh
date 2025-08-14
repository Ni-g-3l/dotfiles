
mold --version 
tool_installed=$?

if [ $tool_installed != 0 ]; then
    git clone --branch stable https://github.com/rui314/mold.git
    cd mold
    ./install-build-deps.sh
    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=c++ -B build
    cmake --build build -j$(nproc)
    sudo cmake --build build --target install

    cd ..
    rm -rf mold
fi
