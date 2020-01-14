# =============================================================================
# install requirements
# =============================================================================

# -----------------------------------------------------------------------------
# install OS dependencies
sudo apt install -y python3-dev python3-pip

# -----------------------------------------------------------------------------
# load virtualenv 
# workon ....

# -----------------------------------------------------------------------------
# install python dependencies
pip install -U pip six numpy wheel setuptools mock 'future>=0.17.1'
pip install -U keras_applications --no-deps
pip install -U keras_preprocessing --no-deps

# =============================================================================
# install Bazel
# =============================================================================

# -----------------------------------------------------------------------------
# Step 1: Add Bazel distribution URI as a package source
sudo apt install curl
curl https://bazel.build/bazel-release.pub.gpg | sudo apt-key add -
echo "deb [arch=amd64] https://storage.googleapis.com/bazel-apt stable jdk1.8" | sudo tee /etc/apt/sources.list.d/bazel.list

# -----------------------------------------------------------------------------
# Step 2: Install and update Bazel
sudo apt update && sudo apt install -y bazel-1.1.0

# =============================================================================
# Build Tensorflow
# =============================================================================

# -----------------------------------------------------------------------------
# Download the TensorFlow source code
git clone https://github.com/tensorflow/tensorflow.git
cd tensorflow

# -----------------------------------------------------------------------------
# Configure the build
./configure

# -----------------------------------------------------------------------------
# build
bazel build --config=opt //tensorflow/tools/pip_package:build_pip_package