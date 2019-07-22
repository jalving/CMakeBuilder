# Note that this script can accept some limited command-line arguments, run
# `julia build_tarballs.jl --help` to see a usage message.
using BinaryBuilder

name = "CMakeBuilder"
version = v"0.1.0"

# Collection of sources required to build CMakeBuilder
sources = [
    "https://cmake.org/files/v3.15/cmake-3.15.0.tar.gz" =>
    "0678d74a45832cacaea053d85a5685f3ed8352475e6ddf9fcb742ffca00199b5",

]

# Bash recipe for building across all platforms
script = raw"""
cd $WORKSPACE/srcdir
ls
cd cmake-3.15.0/
ls
mkdir build
ls
cd build
ls
cmake -DCMAKE_INSTALL_PREFIX=$prefix -DCMAKE_TOOLCHAIN_FILE=/opt/$target/$target.toolchain -DCMAKE_USE_SYSTEM_LIBRARIES=Off -DBUILD_CursesDialog=Off ..
make
make install
exit

"""

# These are the platforms we will build for by default, unless further
# platforms are passed in on the command line
platforms = [
    Linux(:x86_64, libc=:glibc)
]

# The products that we will ensure are always built
products(prefix) = [
    ExecutableProduct(prefix, "cmake", :cmake)
]

# Dependencies that must be installed before this package can be built
dependencies = [
    
]

# Build the tarballs, and possibly a `build.jl` as well.
build_tarballs(ARGS, name, version, sources, script, platforms, products, dependencies)

