Bootstrap: docker
From: fedora:31

%environment
    export INSTALLDIR=/opt/lofar
    . $INSTALLDIR/init.sh
    source $INSTALLDIR/pyenv-py2/bin/activate

%post
    # Most likely to change user settings
    export HAS_CUDA=true
    export HAS_MKL=true
    export MARCH=cascadelake
    export MTUNE=cascadelake
    export NOAVX512=true

	# Settings relevant to the installed software.
	export AOFLAGGER_VERSION=v3.1.0
	export ARMADILLO_VERSION=9.900.3
	export BLAS_VERSION=3.8.0
	export BOOST_VERSION=1.69.0
	export CASACORE_VERSION=v2.4.1
	# Leave at latest, release versions crash for some reason.
	export CASAREST_VERSION=latest
	export CFITSIO_VERSION=7.3.47
    export DPPP_VERSION=v5.2
	export DYSCO_VERSION=v1.2
    export EVERYBEAM_VERSION=083357c1
    export FFTW_VERSION=3.5.8
	export HDF5_VERSION=1.10.5
    #export IDG_VERSION=master
    export IDG_VERSION=f178b254
	export LAPACK_VERSION=3.8.0
	export LOFAR_VERSION=3_2_18
    # Don't change LOSOTO2_VERSION. This is the last commit that plays nice with Python 2.
	export LOSOTO2_VERSION=c8fbd61
	export LOSOTO3_VERSION=latest
    export LSMTOOL_VERSION=v1.4.2
	export OPENBLAS_VERSION=3.8.0
	export PYBDSF_VERSION=master
	export PYTHON_CASACORE_VERSION=v2.2.1
    export RMEXTRACT_VERSION=v0.4.4
	export SUPERLU_VERSION=5.2.1
	export WSCLEAN_VERSION=42c8201e
	export WCSLIB_VERSION=6.4
	export HDF5_USE_FILE_LOCKING=FALSE
    export DEBIAN_FRONTEND=noninteractive
    export OMPI_ALLOW_RUN_AS_ROOT=1
    export OMPI_ALLOW_RUN_AS_ROOT_CONFIRM=1

	# General environment settings.
	export J=6
	export INSTALLDIR=/opt/lofar
	export PYTHON_VERSION=2.7
    export OPENBLAS_NUM_THREADS=1
    export OLD_PYTHONPATH=$PYTHONPATH
	
	# Path to where the patch for python-casacore's setup is stored.
    export PYTHON_CASACORE_PATCH=$INSTALLDIR/python-casacore/python_casacore_setup_patch.patch
    export PATCH_LOFAR=$INSTALLDIR/lofar/lofar.patch
    export PATCH_LOFAR_JOBSERVER=$INSTALLDIR/lofar/patch_lofar_jobserver.patch

    export CC=`which gcc`
    export CXX=`which g++`
    export make=`which make`

# Set up compiler-related variables.
    if [ $NOAVX512 = true ]; then
    export CFLAGS="-march=${MARCH} -mtune=${MTUNE} -mno-avx512f -mno-avx512pf -mno-avx512er -mno-avx512cd -mno-avx512vl -mno-avx512bw -mno-avx512dq -mno-avx512ifma -mno-avx512vbmi"
    export CXXFLAGS="-march=${MARCH} -mtune=${MTUNE} -std=c++11 -mno-avx512f -mno-avx512pf -mno-avx512er -mno-avx512cd -mno-avx512vl -mno-avx512bw -mno-avx512dq -mno-avx512ifma -mno-avx512vbmi"
    else
    export CFLAGS="-march=${MARCH} -mtune=${MTUNE}"
    export CXXFLAGS="-march=${MARCH} -mtune=${MTUNE} -std=c++11"
    fi
    export CPLUS_INCLUDE_PATH="/usr/local/cuda/include:/opt/hdf5/include:/usr/include/openmpi-x86_64:/usr/include/c++/9:$CPLUS_INCLUDE_PATH:/usr/include/python2.7:$INSTALLDIR/casacore/include:/usr/include/boost:/usr/include/cfitsio:$INSTALLDIR/EveryBeam/include":$INSTALLDIR/idg/include
    export CMAKE_INCLUDE_PATH="/usr/local/cuda/include:/opt/hdf5/include:/usr/include/openmpi-x86_64:/usr/include/c++/9:$CPLUS_INCLUDE_PATH:/usr/include/python2.7:$INSTALLDIR/casacore/include:/usr/include/boost:/usr/include/cfitsio:$INSTALLDIR/EveryBeam/include":$INSTALLDIR/idg/include
    export CPATH="/usr/include/openmpi-x86_64/:/usr/local/cuda/include:/opt/hdf5/include:/opt/intel/mkl/include:${INSTALLDIR}/casacore/include:$INSTALLDIR/LOFARBeam/include:$INSTALLDIR/idg/include:$INSTALLDIR/aoflagger/include:$INSTALLDIR/EveryBeam/include:$CPATH"
    export CMAKE_PREFIX_PATH="$INSTALLDIR/aoflagger:$INSTALLDIR/casacore:$INSTALDIR/idg:/opt/hdf5:$INSTALLDIR/lofar:$INSTALLDIR/LOFARBeam:/usr/local/cuda/lib64:/opt/intel/mkl/lib/intel64:/usr/lib64/openmpi:$INSTALLDIR/EveryBeam"
    export LD_LIBRARY_PATH="$INSTALLDIR/aoflagger/lib:$INSTALLDIR/casacore/lib:/opt/hdf5/lib:$INSTALLDIR/idg/lib:$INSTALLDIR/LOFARBeam/lib:$INSTALLDIR/lofarstman/lib64:/usr/local/cuda/lib64:/opt/intel/mkl/lib/intel64:/usr/lib64/openmpi/lib/:$INSTALLDIR/EveryBeam/lib:$LD_LIBRARY_PATH"
    export PATH="/opt/hdf5/bin:/usr/lib64/openmpi/bin:$PATH"

#
# System installs
#
    dnf -y update
    dnf -y install dnf-plugins-core
    dnf -y install patch sudo yum-utils hostname
    dnf -y install git svn wget vim nano
    dnf -y install automake autoconf cmake make
    dnf -y install gcc gcc-c++ gcc-gfortran
    dnf -y install arpack-devel python-devel python3-devel lapack-devel libpng-devel libxml2-devel readline-devel ncurses-devel f2py bzip2-devel libicu-devel python3-scipy python-setuptools gsl gsl-devel gdal gdal-devel libpqxx libpqxx-devel
    dnf -y install bison flex ncurses tar bzip2 which gettext
    dnf -y install cmake3

#dnf -y install hdf5
#dnf -y install hdf5-devel
    dnf -y install python
    dnf -y install python-pip python2-tkinter python3-tkinter
    dnf -y install libsigc++20-devel gtkmm30-devel
    dnf -y install python3-devel
    dnf -y install lua lua-devel
#dnf -y install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
# Specifically for Fedora 31 as links are dead atm.
    dnf -y install https://web.archive.org/web/20210814010216/https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-31.noarch.rpm https://web.archive.org/web/20220627141928/https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-31.noarch.rpm
    dnf -y install pgplot
    dnf -y install python3-numpy-f2py
    dnf -y install qt5
    dnf -y install perf
    dnf -y install rsync
    dnf -y install openmpi openmpi-devel
    dnf -y install htop
    dnf -y install python3-pybind11 pybind11-devel mysql mysql-devel python-devel python3-devel
    dnf -y install gdb


#
# Install Boost
#
    dnf -y install boost boost-devel boost-python2 boost-python2-devel boost-python3 boost-python3-devel

#
# Install FFTW
#
    dnf -y install fftw-devel fftw-libs

#
# Install OpenBLAS
#
    dnf -y install blas-devel

#
# Install SuperLU
#
    dnf -y install SuperLU SuperLU-devel

#
# Install Armadillo
#
    dnf -y install armadillo armadillo-devel

# 
# Setup environment variables used during build
#
    export CC=`which gcc`
    export CXX=`which g++`
    export make=`which make`

    mkdir -p $INSTALLDIR
    export PATH="/usr/lib64/openmpi/bin:$PATH"

###################
# Source installs #
###################
#
# Install cfitsio
#
    dnf -y install cfitsio cfitsio-devel

#
# Install wcslib
#
    dnf -y install wcslib wcslib-devel 

#
# Install HDF5 with parallel support
#
    export CC=`which mpicc`
    export CXX=`which mpic++`
    mkdir /opt/hdf5
    cd /opt/hdf5
    wget https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.10/hdf5-${HDF5_VERSION}/src/hdf5-${HDF5_VERSION}.tar.gz
# For reference. Only needed if building with CMake.
#wget https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.10/hdf5-${HDF5_VERSION}/src/CMake-hdf5-${HDF5_VERSION}.tar.gz
    tar xf hdf5-${HDF5_VERSION}.tar.gz
    cd hdf5-${HDF5_VERSION}
# Thread safety required for WSClean's parallel gridding with facets.
    ./configure -prefix=/opt/hdf5 --enable-build-mode=production --enable-threadsafe --enable-shared --disable-sharedlib-rpath --disable-hl
    make -j $J
    #make check
    make install
    export CC=`which gcc`
	export CXX=`which g++`


    if [ $HAS_MKL = true ]; then
        #
        # Install Intel MKL
        #
        sudo dnf config-manager --add-repo https://yum.repos.intel.com/mkl/setup/intel-mkl.repo
        sudo rpm --import https://yum.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS-2019.PUB
        dnf -y install intel-mkl-2020.0-088 intel-mkl-64bit-2020.0-088
    fi

    if [ $HAS_CUDA = true ]; then
        #
        # Install CUDA 11.3
        #
        sudo dnf -y config-manager --add-repo http://developer.download.nvidia.com/compute/cuda/repos/fedora33/x86_64/cuda-fedora33.repo
        sudo dnf -y clean all
        sudo dnf -y upgrade
        sudo dnf -y install cuda-11-3
    fi

	# Symlinks required for Fedora 31
	ln -s /usr/lib64/libboost_python37.so /usr/lib64/libboost_python3.so
	ln -s /usr/lib64/libboost_numpy37.so /usr/lib64/libboost_numpy3.so
	ln -s /usr/lib64/libboost_python27.so /usr/lib64/libboost_python.so
	ln -s /usr/lib64/libboost_numpy27.so /usr/lib64/libboost_numpy.so
    ln -s /usr/lib64/libnsl.so.2.0.0 /usr/lib64/libnsl.so

    #
    # Setup the Python environment.
    #
    wget https://raw.githubusercontent.com/tikk3r/lofar-grid-hpccloud/fedora/requirements.txt -O $INSTALLDIR/requirements.txt
    wget https://raw.githubusercontent.com/tikk3r/lofar-grid-hpccloud/fedora/requirements3.txt -O $INSTALLDIR/requirements3.txt
    pip2 --version
    pip --version
    pip2 install --upgrade "pip<21.0"
    pip2 install --upgrade setuptools
    pip2 install xmlrunner typing
    pip install --upgrade setuptools
    pip install xmlrunner
    pip2 --no-cache-dir install "virtualenv<21"
    pip --no-cache-dir install virtualenv

    python2 -m virtualenv -h
    virtualenv $INSTALLDIR/pyenv-py2 --python=python2 --pip=20.3.4 --system-site-packages
    source $INSTALLDIR/pyenv-py2/bin/activate
    python -m pip --version
    python -m pip install --no-binary h5py h5py
    python -m pip install --no-deps -r $INSTALLDIR/requirements.txt
    python -m pip install --no-deps "reproject==0.5.1"
    python -m pip install legacystamps
    deactivate

    virtualenv $INSTALLDIR/pyenv-py3 --python=python3
    source $INSTALLDIR/pyenv-py3/bin/activate
    pip install numpy
    export HDF5_VERSION=1.10.5
    pip install --no-binary h5py h5py
    pip install -r $INSTALLDIR/requirements3.txt
    pip install lofar-h5plot
    pip install legacystamps
    deactivate

    source $INSTALLDIR/pyenv-py2/bin/activate

    #
    # Install Montage
    #
    mkdir -p /opt/montage
    cd /opt/montage
    wget https://github.com/Caltech-IPAC/Montage/archive/v6.0.tar.gz -O Montage_v6.0.tar.gz
    tar xf Montage_v6.0.tar.gz
    cd Montage-6.0
    make -j $J
    rm -rf /opt/montage/Montage_v6.0.tar.gz
    

    #
    # Install difmap
    #
    mkdir -p $INSTALLDIR/difmap
    cd $INSTALLDIR/difmap
    #wget ftp://ftp.astro.caltech.edu/pub/difmap/difmap2.5e.tar.gz
    wget https://github.com/tikk3r/lofar-grid-hpccloud/blob/master/misc/difmap2.5e.tar.gz?raw=true -O difmap2.5e.tar.gz
    tar xf difmap2.5e.tar.gz
    cd uvf_difmap
    wget https://raw.githubusercontent.com/nealjackson/loop3_difmap/master/corplt.c -O difmap_src/corplt.c

    sed -i.bak -e '97d' configure
    sed -i.bak -e '97 i PGPLOT_LIB=/usr/lib64/libpgplot.so.5' configure
    ./configure linux-i486-gcc
    export PGPLOT_LIB=/usr/lib64/libpgplot.so.5
    export CFLAGS_OLD=$CFLAGS
    export CFLAGS="-L/usr/lib64/libpgplot.so.5"
    ./makeall
    rm -rf $INSTALLDIR/difmap/*.tar.gz
    export CFLAGS=$CFLAGS_OLD


	#
	# Install PyBDSF
	#
	mkdir -p ${INSTALLDIR}/pybdsf
	cd ${INSTALLDIR}/pybdsf && git clone https://github.com/lofar-astron/pybdsf && cd ${INSTALLDIR}/pybdsf/pybdsf && git checkout ${PYBDSF_VERSION} && echo export PYBDSF_VERSION=$(git rev-parse --short HEAD) >> $INSTALLDIR/init.sh
    cd ${INSTALLDIR}/pybdsf/pybdsf
    python setup.py install
    cd $INSTALLDIR
    rm -rf $INSTALLDIR/pybdsf/pybdsf

	#
	# Install CASAcore
	#
	# Casacore 2.4.1 did not seem to deal well with AVX512 instructions, so disable them if they are available
	mkdir -p ${INSTALLDIR}/casacore/build
	mkdir -p ${INSTALLDIR}/casacore/data
	cd $INSTALLDIR/casacore
    git clone https://github.com/casacore/casacore.git src
	cd ${INSTALLDIR}/casacore/src && git checkout tags/${CASACORE_VERSION} && echo export CASACORE_VERSION=$(git rev-parse --short HEAD) >> $INSTALLDIR/init.sh
    # Backport patch UVFITS for LOFAR. This is fixed in recent versions > May 26 2020
    #wget https://patch-diff.githubusercontent.com/raw/casacore/casacore/pull/1033.patch -O $INSTALLDIR/casacore/1033.patch
    #cd $INSTALLDIR/casacore/src && patch --fuzz 3 -p1 < $INSTALLDIR/casacore/1033.patch
	cd ${INSTALLDIR}/casacore/data && wget --retry-connrefused ftp://anonymous@ftp.astron.nl/outgoing/Measures/WSRT_Measures.ztar
	cd ${INSTALLDIR}/casacore/data && tar xf WSRT_Measures.ztar && rm WSRT_Measures.ztar
	cd ${INSTALLDIR}/casacore/build && cmake -DCMAKE_INSTALL_PREFIX=${INSTALLDIR}/casacore/ -DDATA_DIR=${INSTALLDIR}/casacore/data -DBUILD_PYTHON=True -DUSE_OPENMP=True -DUSE_FFTW3=TRUE -DUSE_HDF5=True -DBUILD_PYTHON3=False ../src/ 
	cd ${INSTALLDIR}/casacore/build && $make -s -j ${J}
	cd ${INSTALLDIR}/casacore/build && $make install
    cd $INSTALLDIR
    rm -rf $INSTALLDIR/casacore/build
    rm -rf $INSTALLDIR/casacore/src

	#
	# Install Python-CASAcore
	#
	mkdir ${INSTALLDIR}/python-casacore
    cd ${INSTALLDIR}/python-casacore && git clone https://github.com/casacore/python-casacore
	cd ${INSTALLDIR}/python-casacore/python-casacore && git checkout tags/${PYTHON_CASACORE_VERSION} && echo export PYTHON_CASACORE_VERSION=$(git rev-parse --short HEAD) >> $INSTALLDIR/init.sh
	cd ${INSTALLDIR}/python-casacore/python-casacore
    python setup.py build_ext -I${INSTALLDIR}/casacore/include/:/usr/include/python2.7 -L${INSTALLDIR}/casacore/lib/:/usr/lib64/
    cd $INSTALLDIR/python-casacore/python-casacore
    python setup.py install #--prefix=${INSTALLDIR}/python-casacore/
    cd $INSTALLDIR
    rm -rf $INSTALLDIR/python-casacore/python-casacore
    
	#
	# Install Dysco
	#
	mkdir -p $INSTALLDIR/dysco/build
	cd $INSTALLDIR/dysco && git clone https://github.com/aroffringa/dysco.git src
    cd src && git checkout $DYSCO_VERSION && echo export DYSCO_VERSION=$(git rev-parse --short HEAD) >> $INSTALLDIR/init.sh
	cd $INSTALLDIR/dysco/build && cmake -DCMAKE_INSTALL_PREFIX=$INSTALLDIR/dysco -DCASACORE_ROOT_DIR=$INSTALLDIR/casacore -DPORTABLE=True ../src && $make -s -j $J && $make install
    cd $INSTALLDIR
    rm -rf $INSTALLDIR/dysco/build
    rm -rf $INSTALLDIR/dysco/src

	#
	# Install AOFlagger
	#
    source $INSTALLDIR/pyenv-py3/bin/activate
	mkdir -p ${INSTALLDIR}/aoflagger/build
	cd ${INSTALLDIR}/aoflagger && git clone https://gitlab.com/aroffringa/aoflagger.git src && cd ${INSTALLDIR}/aoflagger/src && git checkout ${AOFLAGGER_VERSION} && echo export DYSCO_VERSION=$(git rev-parse --short HEAD) >> $INSTALLDIR/init.sh
	cd ${INSTALLDIR}/aoflagger/build && cmake -DCMAKE_INSTALL_PREFIX=${INSTALLDIR}/aoflagger/ -DCASACORE_ROOT_DIR=${INSTALLDIR}/casacore -DBUILD_SHARED_LIBS=ON -DPORTABLE=True ../src
	cd ${INSTALLDIR}/aoflagger/build && $make -s -j ${J}
	cd ${INSTALLDIR}/aoflagger/build && $make install
    cd $INSTALLDIR
    rm -rf $INSTALLDIR/aoflagger/aoflagger
    rm -rf $INSTALLDIR/aoflagger/build
    rm -rf $INSTALLDIR/aoflagger/src
	deactivate
    source $INSTALLDIR/pyenv-py2/bin/activate

	#
	# Install LOFAR
	#
	mkdir -p ${INSTALLDIR}/lofar/build/gnucxx11_opt
	if [ "${LOFAR_VERSION}" = "latest" ]; then cd ${INSTALLDIR}/lofar && svn checkout https://svn.astron.nl/LOFAR/trunk src; fi
	if [ "${LOFAR_VERSION}" != "latest" ]; then cd ${INSTALLDIR}/lofar && svn checkout https://svn.astron.nl/LOFAR/tags/LOFAR-Release-${LOFAR_VERSION} src; fi
	cd $INSTALLDIR/lofar && svn update --depth=infinity $INSTALLDIR/lofar/src/CMake
	wget https://raw.githubusercontent.com/tikk3r/lofar-grid-hpccloud/fedora/patches/lofar.patch
	patch $INSTALLDIR/lofar/src/CMake/variants/GNUCXX11.cmake $PATCH_LOFAR
    # makesourcedb and showsourcedb are covered by DPPP already.
    rm ${INSTALLDIR}/lofar/src/CEP/ParmDB/src/makesourcedb.cc
    #rm ${INSTALLDIR}/lofar/src/CEP/ParmDB/src/showsourcedb.cc
    sed -i '/makesourcedb/d' $INSTALLDIR/lofar/src/CEP/ParmDB/src/CMakeLists.txt
    sed -i '/makesourcedb/d' $INSTALLDIR/lofar/src/CEP/ParmDB/test/CMakeLists.txt
    #sed '/showsourcedb/d' $INSTALLDIR/lofar/src/CEP/ParmDB/src/CMakeLists.txt > ${INSTALLDIR}/lofar/src/CEP/ParmDB/src/CMakeLists.txt
	cd ${INSTALLDIR}/lofar/build/gnucxx11_opt
    #cmake -DCMAKE_PREFIX_PATH=$INSTALLDIR/aoflagger:$INSTALLDIR/casacore:$INSTALLDIR/dysco -DBUILD_PACKAGES="StationResponse pystationresponse ParmDB pyparmdb Pipeline MS" -DCMAKE_INSTALL_PREFIX=$INSTALLDIR/lofar/ -DUSE_LOG4CPLUS=OFF -DUSE_OPENMP=True ${INSTALLDIR}/lofar/src/
    cmake -DBUILD_PACKAGES="Pipeline ParmDB pyparmdb" -DCMAKE_INSTALL_PREFIX=$INSTALLDIR/lofar/ -DUSE_LOG4CPLUS=OFF -DUSE_OPENMP=True -DBUILD_PYTHON3=OFF ${INSTALLDIR}/lofar/src/
	$make -s -j $J
	$make install
    # Patch jobserver.py
	wget https://raw.githubusercontent.com/tikk3r/lofar-grid-hpccloud/fedora/patches/patch_lofar_jobserver.patch -O $PATCH_LOFAR_JOBSERVER
    patch $INSTALLDIR/lofar/lib64/python2.7/site-packages/lofarpipe/support/jobserver.py $PATCH_LOFAR_JOBSERVER
    cd $INSTALLDIR
    rm -rf $INSTALLDIR/lofar/build
    rm -rf $INSTALLDIR/lofar/src

    #
    # Install LofarStMan
    #
    mkdir -p $INSTALLDIR/lofarstman
    cd $INSTALLDIR/lofarstman
    git clone https://github.com/lofar-astron/LofarStMan.git
    cd LofarStMan
    mkdir build && cd build
    cmake -DCASACORE_ROOT_DIR=$INSTALLDIR/casacore -DCMAKE_INSTALL_PREFIX=$INSTALLDIR/lofarstman ..
    make -j$J
    make install
    cd $INSTALLDIR

    #
    # Install msoverview separately
    #
    mkdir -p $INSTALLDIR/msoverview/src
    cd $INSTALLDIR/msoverview/src
    svn export https://svn.astron.nl/LOFAR/tags/LOFAR-Release-3_2_18/CEP/MS/src/msoverview.cc
    gcc -I/opt/lofar/casacore/include/casacore/ -L/opt/lofar/casacore/lib msoverview.cc -o $INSTALLDIR/lofar/bin/msoverview -lcasa_casa -lcasa_ms -lcasa_tables -lstdc++
    cd $INSTALLDIR
    rm -rf $INSTALLDIR/msoverview
    
    #
    # Install the standalone StationResponse libraries.
    #   
    echo Installing LOFARBeam...
    mkdir -p $INSTALLDIR/LOFARBeam/build
    cd $INSTALLDIR/LOFARBeam
    git clone https://github.com/lofar-astron/LOFARBeam.git src
    cd src
    echo export LOFARBEAM_VERSION=$(git rev-parse --short HEAD) >> $INSTALLDIR/init.sh
    cd ../build
    # Install in the existing lofar python folder
    cmake -DCMAKE_INSTALL_PREFIX=$INSTALLDIR/lofar ../src
    $make -j $J
    $make install
    touch /opt/lofar/lofar/lib64/python2.7/site-packages/lofar/__init__.py
    cd $INSTALLDIR
    rm -rf $INSTALLDIR/LOFARBeam/build
    rm -rf $INSTALLDIR/LOFARBeam/src

    #
    # Install EveryBeam library
    #
    echo Installing EveryBeam
    mkdir -p $INSTALLDIR/EveryBeam/build
    cd $INSTALLDIR/EveryBeam
    git clone https://git.astron.nl/RD/EveryBeam.git src
    cd src && git checkout $EVERYBEAM_VERSION
    echo export EVERYBEAM_VERSION=$(git rev-parse --short HEAD) >> $INSTALLDIR/init.sh
    cd $INSTALLDIR/EveryBeam/build
    cmake -DCMAKE_INSTALL_PREFIX=$INSTALLDIR/EveryBeam ../src
    $make -j $J
    $make install

    #   
    # Install Image Domain Gridder (IDG)
    #   
    mkdir -p $INSTALLDIR/idg && cd $INSTALLDIR/idg
    #git clone https://gitlab.com/astron-idg/idg.git src 
    git clone https://git.astron.nl/RD/idg.git src
        cd src && git checkout $IDG_VERSION && echo export IDG_VERSION=$(git rev-parse --short HEAD) >> $INSTALLDIR/init.sh && mkdir build && cd build
    if [ $HAS_CUDA = true ] && [ $HAS_MKL = true ]; then
        cmake3 -DCMAKE_INSTALL_PREFIX=$INSTALLDIR/idg -DBUILD_WITH_MKL=ON -DMKL_LIBRARIES=/opt/intel/mkl/lib/intel64/libmkl_rt.so -DMKL_INCLUDE_DIRS=/opt/intel/mkl/include -DBUILD_LIB_CUDA=ON -DCUDAToolkit_BIN_DIR=/usr/local/cuda/bin -DCMAKE_BUILD_TYPE=Debug ..
    elif [ $HAS_CUDA = false ] && [ $HAS_MKL = true ]; then
        cmake3 -DCMAKE_INSTALL_PREFIX=$INSTALLDIR/idg -DBUILD_WITH_MKL=ON -DMKL_LIBRARIES=/opt/intel/mkl/lib/intel64/libmkl_rt.so -DMKL_INCLUDE_DIRS=/opt/intel/mkl/include  -DCMAKE_BUILD_TYPE=Debug ..
    elif [ $HAS_CUDA = true ] && [ $HAS_MKL = false ]; then
        cmake3 -DCMAKE_INSTALL_PREFIX=$INSTALLDIR/idg -DBUILD_WITH_MKL=OFF -DBUILD_LIB_CUDA=ON -DCUDAToolkit_BIN_DIR=/usr/local/cuda/bin -DCMAKE_BUILD_TYPE=Debug -DBLAS_openblas_LIBRARY=/usr/lib64/libopenblasp.so -DBLAS_blas_LIBRARY=/usr/lib64/libopenblasp.so ..
    else
        cmake3 -DCMAKE_INSTALL_PREFIX=$INSTALLDIR/idg -DBLAS_openblas_LIBRARY=/usr/lib64/libopenblasp.so -DBLAS_blas_LIBRARY=/usr/lib64/libopenblasp.so ..
    fi
    make -j $J
    make install
    cd $INSTALLDIR
    rm -rf $INSTALLDIR/idg/src

    #
    # Install DPPP
    #
    mkdir -p $INSTALLDIR/DPPP/build
    git clone https://git.astron.nl/RD/DP3.git $INSTALLDIR/DPPP/src
    cd $INSTALLDIR/DPPP/src
    git checkout ${DPPP_VERSION}
    echo export DPPP_VERSION=$(git rev-parse --short HEAD) >> $INSTALLDIR/init.sh
    cd $INSTALLDIR/DPPP/build
    # Temporarily get rid of MKL. Throws an error about needing a not-OpenMP version of OpenBLAS and MKL's multithreaded stuff uses OpenMP from what I can tell.
    if [ $HAS_MKL = true ]; then
        export LD_LIBRARY_PATH=$(echo $LD_LIBRARY_PATH | tr ":" "\n" | grep -v "/opt/intel" | tr "\n" ":")
        export CPATH=$(echo $CPATH | tr ":" "\n" | grep -v "/opt/intel" | tr "\n" ":")
        export CMAKE_PREFIX_PATH=$(echo $CMAKE_PREFIX_PATH | tr ":" "\n" | grep -v "/opt/intel" | tr "\n" ":")
    fi
    # Link to libopenblasp.so (note the p) and not libopenblas.so so we get the multi-threaded version.
    if [ $MARCH = 'x86-64' ] && [ $MTUNE = 'generic' ]; then
        cmake3 -DCMAKE_CXX_FLAGS="-D_GLIB_USE_CXX_ABI=1 -DBOOST_NO_CXX11_SCOPED_ENUMS" -DCMAKE_INSTALL_PREFIX:PATH=$INSTALLDIR/DPPP -DLOFAR_STATION_RESPONSE_DIR:PATH=$INSTALLDIR/lofar/include -DLOFAR_STATION_RESPONSE_LIB:FILEPATH=$INSTALLDIR/lofar/lib/libstationresponse.so -DIDGAPI_LIBRARIES=$INSTALLDIR/idg/lib/libidg-api.so -DIDGAPI_INCLUDE_DIRS=$INSTALLDIR/idg/include -DAOFLAGGER_INCLUDE_DIR=$INSTALLDIR/aoflagger/include -DAOFLAGGER_LIB=$INSTALLDIR/aoflagger/lib/libaoflagger.so -DBLAS_openblas_LIBRARY:FILEPATH=/usr/lib64/libopenblasp.so -DPORTABLE=True ../src
    else
        cmake3 -DCMAKE_CXX_FLAGS="-D_GLIB_USE_CXX_ABI=1 -DBOOST_NO_CXX11_SCOPED_ENUMS" -DCMAKE_INSTALL_PREFIX:PATH=$INSTALLDIR/DPPP -DLOFAR_STATION_RESPONSE_DIR:PATH=$INSTALLDIR/lofar/include -DLOFAR_STATION_RESPONSE_LIB:FILEPATH=$INSTALLDIR/lofar/lib/libstationresponse.so -DIDGAPI_LIBRARIES=$INSTALLDIR/idg/lib/libidg-api.so -DIDGAPI_INCLUDE_DIRS=$INSTALLDIR/idg/include -DAOFLAGGER_INCLUDE_DIR=$INSTALLDIR/aoflagger/include -DAOFLAGGER_LIB=$INSTALLDIR/aoflagger/lib/libaoflagger.so -DBLAS_openblas_LIBRARY:FILEPATH=/usr/lib64/libopenblasp.so -DTARGET_CPU=${MARCH} ../src
    fi
    $make -s -j $J && $make install
    cd $INSTALLDIR
    rm -rf $INSTALLDIR/DPPP/build
    rm -rf $INSTALLDIR/DPPP/src
    if [ $HAS_MKL = true ]; then
        export LD_LIBRARY_PATH=/opt/intel/mkl/lib/intel64:$LD_LIBRARY_PATH
        export CPATH=/opt/intel/mkl/include:$CPATH
        export CMAKE_PREFIX_PATH=/opt/intel/mkl/lib/intel64:$CMAKE_PREFIX_PATH
    fi

    ############################################
    # Install Python packages for Python 2 now #
    ############################################
	#
	# Install RMextract
	#
	mkdir -p $INSTALLDIR/RMextract/build
	cd $INSTALLDIR/RMextract/build
    git clone https://github.com/lofar-astron/RMextract.git src
    cd src
    if [ "$RMEXTRACT_VERSION" != "latest" ]; then git checkout $RMEXTRACT_VERSION; fi
    python setup.py build --add-lofar-utils
    python setup.py install --add-lofar-utils
    cd $INSTALLDIR
    rm -rf $INSTALLDIR/RMextract

	#
	# Install LoSoTo
	#
	mkdir -p $INSTALLDIR/losoto/build
	cd ${INSTALLDIR}/losoto/build
    git clone https://github.com/revoltek/losoto.git src
    cd src
    if [ "$LOSOTO2_VERSION" != "latest" ]; then git checkout $LOSOTO2_VERSION; fi
    python setup.py build
    python setup.py install
    cd $INSTALLDIR
    rm -rf $INSTALLDIR/losoto

	#
	# Install LSMTool.
	#
	mkdir -p $INSTALLDIR/lsmtool
	cd $INSTALLDIR/lsmtool
    git clone https://github.com/darafferty/LSMTool.git lsmtool 
	cd $INSTALLDIR/lsmtool/lsmtool
    if [ "$LSMTOOL_VERSION" != "latest" ]; then git checkout $LSMTOOL_VERSION; fi
	python setup.py install
    cd $INSTALLDIR
	rm -rf $INSTALLDIR/lsmtool

    ############################################
    # Install Python packages for Python 3 now #
    ############################################
    deactivate
    source $INSTALLDIR/pyenv-py3/bin/activate

	#
	# Install LoSoTo
	#
	mkdir -p $INSTALLDIR/losoto/build
	cd $INSTALLDIR/losoto/build
    git clone https://github.com/revoltek/losoto.git src
    cd src
    python setup.py build
    python setup.py install
    cd $INSTALLDIR
    rm -rf $INSTALLDIR/losoto
    deactivate

    #
    # Install-WSClean
    #
    mkdir $INSTALLDIR/wsclean
    cd ${INSTALLDIR}/wsclean && git clone https://gitlab.com/aroffringa/wsclean.git && cd wsclean && git checkout $WSCLEAN_VERSION && echo export WSCLEAN_VERSION=$(git rev-parse --short HEAD) >> $INSTALLDIR/init.sh
    mkdir build && cd build
    # Switch to mpicc for a minute
    export CC=`which mpicc`
    export CXX=`which mpic++`
    # TARGET_CPU is a WSClean 2.10.2 feature. Change to PORTABLE=TRUE if using and older version to avoid -march=native being triggered.
    if [ $MARCH = 'x86-64' ] && [ $MTUNE = 'generic' ]; then
        cmake -DCMAKE_INSTALL_PREFIX=$INSTALLDIR/wsclean -DPORTABLE=True -DBLAS_openblas_LIBRARY=/usr/lib64/libopenblasp.so -DPYTHON_LIBRARIES=/usr/lib64/libpython3.so -DPYTHON_INCLUDE_DIRS=/usr/include/python3.7m/ -DIDGAPI_DIR:PATH=/opt/lofar/idg/share/idgapi/cmake/ ..
    else
        cmake -DCMAKE_INSTALL_PREFIX=$INSTALLDIR/wsclean -DTARGET_CPU=${MARCH} -DBLAS_openblas_LIBRARY=/usr/lib64/libopenblasp.so -DPYTHON_LIBRARIES=/usr/lib64/libpython3.so -DPYTHON_INCLUDE_DIRS=/usr/include/python3.7m/ -DIDGAPI_DIR:PATH=/opt/lofar/idg/share/idgapi/cmake/ ..
    fi
    $make -j ${J}
    $make install
    cd $INSTALLDIR
    rm -rf $INSTALLDIR/wsclean/wsclean
    # Switch back to normal compilers
    export CC=`which gcc`
    export CXX=`which g++`
    source $INSTALLDIR/pyenv-py2/bin/activate

    #
    # Install DS9
    #
    mkdir -p $INSTALLDIR/ds9/bin
    cd $INSTALLDIR/ds9
    wget https://ds9.si.edu/download/fedora33/ds9.fedora33.8.3.tar.gz
    tar xf ds9*.tar.gz -C $INSTALLDIR/ds9/bin
    rm ds9*.tar.gz

	echo "Installation directory contents:"
	ls $INSTALLDIR
    
    #
    # Install ddf related stuff
    #
    export DDFACET_VERSION=v0.5.3.1
    export KILLMS_VERSION=v3.0.1

    # Path to where the patch for python-casacore's setup is stored.
    export PATCH_KILLMS_MAKEFILE_PREDICT=$INSTALLDIR/patches/patch_killms_predict.patch
    export PATCH_KILLMS_MAKEFILE_ARRAY=$INSTALLDIR/patches/patch_killms_array.patch
    export PATCH_KILLMS_MAKEFILE_GRIDDER=$INSTALLDIR/patches/patch_killms_gridder.patch
    export PATCH_DDFACET_CPUS=$INSTALLDIR/patches/DDFacet_cpus.patch

    mkdir -p $INSTALLDIR/patches
    cd $INSTALLDIR && git clone --single-branch -b fedora https://github.com/tikk3r/lofar-grid-hpccloud.git
    mv $INSTALLDIR/lofar-grid-hpccloud/patches/* $INSTALLDIR/patches

    #
    # Install killMS
    #
    mkdir -p $INSTALLDIR
    cd $INSTALLDIR && git clone --single-branch -b v2.6 https://github.com/saopicc/killMS.git
    cd killMS
    patch $INSTALLDIR/killMS/Predict/Makefile $PATCH_KILLMS_MAKEFILE_PREDICT
    patch $INSTALLDIR/killMS/Array/Dot/Makefile $PATCH_KILLMS_MAKEFILE_ARRAY
    patch $INSTALLDIR/killMS/Gridder/Makefile $PATCH_KILLMS_MAKEFILE_GRIDDER
    cd $INSTALLDIR/killMS/Predict && make
    cd $INSTALLDIR/killMS/Array/Dot && make
    cd $INSTALLDIR/killMS/Gridder && make

    #
    # Install DDFacet
    #
    mkdir -p $INSTALLDIR/DDFacet
    cd $INSTALLDIR/DDFacet
    git clone --single-branch -b $DDFACET_VERSION https://github.com/saopicc/DDFacet.git src
    patch $INSTALLDIR/DDFacet/src/DDFacet/Other/AsyncProcessPool.py $PATCH_DDFACET_CPUS
    cd src
    sed -i '/bdsf/d' setup.py
    python setup.py install --prefix=$INSTALLDIR/DDFacet

    #   
    # Install DynSpecMS
    #   
    cd $INSTALLDIR && git clone https://github.com/cyriltasse/DynSpecMS.git

    #
    # Install ddf-pipeline
    #
    cd $INSTALLDIR && git clone https://github.com/mhardcastle/ddf-pipeline.git
    # Commits after this break the pipeline, because they contain Python 3 preparations that NumPy 1.16.0 (required for MeqTrees) does not like.
    cd ddf-pipeline && git checkout fe5393d && cd ..
    sed -i 's?DDF\.py?DDF\.py --Misc-IgnoreDeprecationMarking=True?' /opt/lofar/ddf-pipeline/scripts/pipeline.py
    # Download DDF catalogues.
    mkdir -p $INSTALLDIR/DDFCatalogues
    cd $INSTALLDIR/DDFCatalogues
    #wget ftp://ftp.strw.leidenuniv.nl/pub/shimwell/bootstrap-cats.tar
    #wget https://surfdrive.surf.nl/files/index.php/s/u7liDZH3SlWalwy/download -O bootstrap-cats.tar
    #tar xf bootstrap-cats.tar -C $INSTALLDIR/DDFCatalogues --strip-components=1
    wget https://www.extragalactic.info/bootstrap/VLSS.fits
    wget https://www.extragalactic.info/bootstrap/wenss.fits
    wget https://www.extragalactic.info/bootstrap/B2.fits
    wget https://www.extragalactic.info/bootstrap/NVSS.fits
    wget https://lambda.gsfc.nasa.gov/data/foregrounds/tgss_adr/TGSSADR1_7sigma_catalog.fits
    cd $INSTALLDIR


    #
    # Wrap up installation, remove unnecessary stuff.
    export PYTHONPATH=$OLD_PYTHONPATH
    dnf -y autoremove
    dnf -y clean all
    rm -rf /var/cache/dnf/*
    rm -rf /var/cache/yum/*
    rm -rf /var/log/*
    unset J

	#
	# init-lofar
	#
	ln -f -s /opt/lofar/DPPP/bin/DP3 /opt/lofar/lofar/bin/NDPPP
	ln -s /opt/lofar/DPPP/bin/makesourcedb /opt/lofar/lofar/bin/makesourcedb
    ln -s $INSTALLDIR/pyenv-py3/bin/h5plot /usr/bin/h5plot

    # Store version information.
	echo export ARMADILLO_VERSION=$ARMADILLO_VERSION >> $INSTALLDIR/init.sh
	echo export BLAS_VERSION=$BLAS_VERSION >> $INSTALLDIR/init.sh
	echo export BOOST_VERSION=$BOOST_VERSION >> $INSTALLDIR/init.sh
	echo export CASAREST_VERSION=$CASAREST_VERSION >> $INSTALLDIR/init.sh
	echo export CFITSIO_VERSION=$CFITSIO_VERSION >> $INSTALLDIR/init.sh
    echo export FFTW_VERSION=$FFTW_VERSION >> $INSTALLDIR/init.sh
	echo export HDF5_VERSION=$HDF5_VERSION >> $INSTALLDIR/init.sh
	echo export LAPACK_VERSION=$LAPACK_VERSION >> $INSTALLDIR/init.sh
	echo export LOFAR_VERSION=$LOFAR_VERSION >> $INSTALLDIR/init.sh
	echo export LOSOTO2_VERSION=$LOSOTO2_VERSION >> $INSTALLDIR/init.sh
	echo export LOSOTO3_VERSION=$LOSOTO3_VERSION >> $INSTALLDIR/init.sh
    echo export LSMTOOL_VERSION=$LSMTOOL_VERSION >> $INSTALLDIR/init.sh
	echo export OPENBLAS_VERSION=$OPENBLAS_VERSION >> $INSTALLDIR/init.sh
    echo export RMEXTRACT_VERSION=$RMEXTRACT_VERSION >> $INSTALLDIR/init.sh
	echo export SUPERLU_VERSION=$SUPERLU_VERSION >> $INSTALLDIR/init.sh
	echo export WCSLIB_VERSION=$WCSLIB_VERSION >> $INSTALLDIR/init.sh
	echo export HDF5_USE_FILE_LOCKING=$HDF5_USE_FILE_LOCKING >> $INSTALLDIR/init.sh

    echo export MARCH=$MARCH >> $INSTALLDIR/init.sh
    echo export MTUNE=$MTUNE >> $INSTALLDIR/init.sh
    echo $'export MARCH_MACHINE=$(gcc -march=native -Q --help=target | grep "\-march=" | head -n 1 | awk \'{print $2}\')' >> $INSTALLDIR/init.sh
    echo $'export MTUNE_MACHINE=$(gcc -mtune=native -Q --help=target | grep "\-mtune=" | head -n 1 | awk \'{print $2}\')' >> $INSTALLDIR/init.sh
    echo $'if [ "$MARCH_MACHINE" != "$MARCH" ]; then echo "WARNING - software has been build with -march=$MARCH but current machine reports -march=$MARCH_MACHINE.\nIf you encounter strange behaviour or Illegal instruction warnings, consider building a container with the appropriate architecture set."; fi' >> $INSTALLDIR/init.sh
    echo $'if [ "$MTUNE_MACHINE" != "$MTUNE" ]; then echo "WARNING - software has been build with -mtune=$MTUNE but current machine -mtune=$MTUNE_MACHINE.\nIf you encounter strange behaviour or Illegal instruction warnings, consider building a container with the appropriate architecture set."; fi' >> $INSTALLDIR/init.sh
	echo export INSTALLDIR=$INSTALLDIR >> $INSTALLDIR/init.sh
	echo export HDF5_USE_FILE_LOCKING=FALSE >> $INSTALLDIR/init.sh
	echo source \$INSTALLDIR/lofar/lofarinit.sh  >> $INSTALLDIR/init.sh
	echo export PYTHONPATH=\$INSTALLDIR/dppp:\$INSTALLDIR/lofar/lib64/python2.7/site-packages >> $INSTALLDIR/init.sh

	echo export INSTALLDIR=$INSTALLDIR >> $INSTALLDIR/init.sh

    echo export PATH=/usr/local/cuda/bin:/opt/hdf5/bin:\$PATH >> $INSTALLDIR/init.sh
	echo export PATH=/opt/montage/Montage-6.0/bin:\$PATH  >> $INSTALLDIR/init.sh
	echo export PATH=\$INSTALLDIR/aoflagger/bin:\$PATH  >> $INSTALLDIR/init.sh
	echo export PATH=\$INSTALLDIR/casacore/bin:\$PATH  >> $INSTALLDIR/init.sh
    echo export PATH=\$INSTALLDIR/ds9/bin:\$PATH >> $INSTALLDIR/init.sh
	echo export PATH=\$INSTALLDIR/DPPP/bin:\$PATH  >> $INSTALLDIR/init.sh
    echo export PATH=\$INSTALLDIR/difmap/uvf_difmap:\$PATH >> $INSTALLDIR/init.sh
	echo export PATH=\$INSTALLDIR/dysco/bin:\$PATH  >> $INSTALLDIR/init.sh
	echo export PATH=/opt/hdf5/bin:\$PATH  >> $INSTALLDIR/init.sh
	echo export PATH=\$INSTALLDIR/lofar/bin:\$PATH  >> $INSTALLDIR/init.sh
	echo export PATH=\$INSTALLDIR/wsclean/bin:\$PATH  >> $INSTALLDIR/init.sh
    echo export PATH=/usr/lib64/openmpi/bin:\$PATH >> $INSTALLDIR/init.sh

    echo export LD_LIBRARY_PATH=/usr/lib64/openmpi/lib/:\$LD_LIBRARY_PATH >> $INSTALLDIR/init.sh
    echo export LD_LIBRARY_PATH=/usr/local/cuda/lib64:/opt/hdf5/lib:/opt/intel/mkl/lib/intel64/:\$LD_LIBRARY_PATH >> $INSTALLDIR/init.sh
	echo export LD_LIBRARY_PATH=\$INSTALLDIR/aoflagger/lib:\$INSTALLDIR/casacore/lib:\$INSTALLDIR/DPPP/lib:\$INSTALLDIR/dysco/lib:\$INSTALLDIR/EveryBeam/lib:/opt/hdf5/lib:\$INSTALLDIR/idg/lib:\$INSTALLDIR/lofar/lib:\$INSTALLDIR/lofar/lib64:\$INSTALLDIR/LOFARBeam/lib:\$INSTALLDIR/lofarstman/lib64:\$LD_LIBRARY_PATH  >> $INSTALLDIR/init.sh

    echo export HAS_CUDA=$HAS_CUDA >> $INSTALLDIR/init.sh
    echo export HAS_MKL=$HAS_MKL >> $INSTALLDIR/init.sh
    echo export NOAVX512=$NOAVX512 >> $INSTALLDIR/init.sh

    echo export NCPU=\$\(nproc --all\) >> $INSTALLDIR/init.sh
    echo export OPENBLAS_NUM_THREADS=1 >> $INSTALLDIR/init.sh
    echo export OPENBLAS_MAX_THREADS=\$\{SLURM_CPUS_PER_TASK:-\$\(nproc --all\)\} >> $INSTALLDIR/init.sh
    echo export OMP_NUM_THREADS=\$\{SLURM_CPUS_PER_TASK:-\$\(nproc --all\)\} >> $INSTALLDIR/init.sh
    echo export OMP_MAX_THREADS=\$\{SLURM_CPUS_PER_TASK:-\$\(nproc --all\)\} >> $INSTALLDIR/init.sh


	echo export PYTHONPATH=\$INSTALLDIR/DPPP/lib/python3.7/site-packages:\$INSTALLDIR/lofar/lib64/python2.7/site-packages:\$PYTHONPATH >> $INSTALLDIR/init_py2.sh
    echo source \$INSTALLDIR/pyenv-py2/bin/activate >> $INSTALLDIR/init_py2.sh

    echo "measures.directory: $INSTALLDIR/casacore/data" > $INSTALLDIR/.casarc 
    echo export CASARCFILES=\$INSTALLDIR/.casarc >> $INSTALLDIR/init.sh

    echo "# DDF environment settings" >> $INSTALLDIR/init.sh
    echo export DDF_DIR=$INSTALLDIR >> $INSTALLDIR/init.sh
    echo export DDF_PIPELINE_CATALOGS=$INSTALLDIR/DDFCatalogues >> $INSTALLDIR/init.sh
    echo export KILLMS_DIR=$INSTALLDIR >> $INSTALLDIR/init.sh
    echo export PYTHONPATH=$INSTALLDIR:$INSTALLDIR/ddf-pipeline/scripts:$INSTALLDIR/ddf-pipeline/utils:$INSTALLDIR/DDFacet/lib/python2.7/site-packages:$INSTALLDIR/killMS:$INSTALLDIR/killMS/Predict:$INSTALLDIR/killMS/Array:$INSTALLDIR/killMS/Array/Dot:$INSTALLDIR/killMS/Gridder:$INSTALLDIR/DDFacet/bin:$INSTALLDIR/DynSpecMS:\$PYTHONPATH >> $INSTALLDIR/init.sh
    echo export PATH=$INSTALLDIR/DDFacet/bin:$INSTALLDIR/DDFacet/src/SkyModel:$INSTALLDIR/DynSpecMS/:$INSTALLDIR/killMS:$INSTALLDIR/ddf-pipeline/scripts:\$PATH >> $INSTALLDIR/init.sh
    echo "if echo \$(hostname) | grep -qi leiden; then export DDF_PIPELINE_CLUSTER="paracluster"; else export DDF_PIPELINE_CLUSTER=; fi" >> $INSTALLDIR/init.sh


%runscript
    echo LOFAR-SKSP Singularity Container v3.3.6

%help
    This Singularity image contains an install of LOFAR 3.2.18. In order to run your pipelines, you may need to know where the software is installed. The root directory is /opt/lofar, with most software installed as follows:

    * AOFlagger: $INSTALLDIR/aoflagger
    * Casacore: $INSTALLDIR/casacore
    * Difmap: $INSTALLDIR/difmap
    * DP3: $INSTALLDIR/DPPP
    * Dysco: $INSTALLDIR/dysco
    * DS9: $INSTALLDIR/ds9
    * Dysco: $INSTALLDIR/dysco
    * EveryBeam: $INSTALLDIR/EveryBeam
    * IDG: $INSTALLDIR/idg
    * LOFAR: $INSTALLDIR/lofar
    * WSClean: $INSTALLDIR/wsclean

    Python packages such as losoto, lsmtool and RMextract are available in the environment /opt/lofar/pyenv-py2. By default this Python 2 environment is already active.

    To execute a command directly, use
        singularity exec -B <paths,that,need,to,be,accessible> <path to image> <command> <arguments>
    for example, to run a genericpipeline parset, the following command can be used:
        singularity exec lofar.simg genericpipeline.py -d -c pipeline.cfg pipeline.parset
    To enter a shell within the image, use
        singularity shell -B <paths,that,need,to,be,accessible> <path to image>

    The container base is Fedora 31 and relevant key dependencies have the following versions:

    * Armadillo 9.900.3
    * Boost 1.69.0
    * CFITSIO 7.3.47
    * FFTW 3.5.8
    * HDF5 1.10.5
    * LAPACK 3.8.0
    * OpenBLAS 3.8.0
    * SuperLU 5.2.1
    * WCSLIB 6.4
