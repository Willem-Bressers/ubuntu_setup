# https://medium.com/@anujonthemove/an-almost-definitive-guide-for-setting-up-geospatial-data-abstraction-library-gdal-on-e3c590ecde0f

GDAL_VERSION=3.0.2
PROJ_VERSION=6.0.0
INSTALL_DIR=/usr/local

sudo apt install -y python3-dev sqlite3 libsqlite3-dev

# -----------------------------------------------------------------------------
# Download proj 6
wget http://download.osgeo.org/proj/proj-$PROJ_VERSION.zip -O $HOME/Downloads/proj-$PROJ_VERSION.zip

# extract it
unzip $HOME/Downloads/proj-$PROJ_VERSION.zip -d $HOME/Downloads

# navigate into it
cd $HOME/Downloads/proj-$PROJ_VERSION

# configure
./configure

# build
make -j$($nproc)

# -----------------------------------------------------------------------------

# download the version
wget http://download.osgeo.org/gdal/$GDAL_VERSION/gdal-$GDAL_VERSION.tar.gz -O $HOME/Downloads/gdal-$GDAL_VERSION.tar.gz

# extract the archive
tar xvf $HOME/Downloads/gdal-$GDAL_VERSION.tar.gz -C $HOME/Downloads

# navigate into the folder
cd $HOME/Downloads/gdal-$GDAL_VERSION/

# configure the installation
# ./configure --with-python --prefix=/usr/
./configure --with-python=python3 --with-proj=$INSTALL_DIR


make -j$($nproc)
sudo make install