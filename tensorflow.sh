BAZEL_VERSION=0.26.1
TENSORFLOW_VERSION=2.0.0
TENSORFLOW_TAG=v${TENSORFLOW_VERSION}

# https://www.tensorflow.org/install/source

sudo apt install -y python3 python3-dev python3-pip pkg-config zip g++ zlib1g-dev unzip

# pip3 install -U --user pip six numpy wheel setuptools mock 'future>=0.17.1'
# pip3 install -U --user keras_applications==1.0.6 --no-deps
# pip3 install -U --user keras_preprocessing==1.0.5 --no-deps

# install Bazel
wget https://github.com/bazelbuild/bazel/releases/download/${BAZEL_VERSION}/bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh -O /tmp/bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh
chmod +x /tmp/bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh
/tmp/bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh --user

export PATH="$PATH:$HOME/bin"
# echo "export PATH=${PATH}:${HOME}/bin" >> ~/.bashrc

# Dowload tensorflow
wget https://github.com/tensorflow/tensorflow/archive/${TENSORFLOW_TAG}.tar.gz -O /tmp/tensorflow-${TENSORFLOW_TAG}.tar.gz
tar xvzf /tmp/tensorflow-${TENSORFLOW_TAG}.tar.gz -C /tmp
cd /tmp/tensorflow-${TENSORFLOW_VERSION}

# configure tensorflow
./configure

# build tensorflow
bazel build -c opt --copt=-mavx --copt=-mavx2 --copt=-mfma --copt=-mfpmath=both --config=v2 -k //tensorflow/tools/pip_package:build_pip_package

# bazel build -c opt --copt=-mavx --copt=-mavx2 --copt=-mfma --copt=-mfpmath=both --config=cuda -k //tensorflow/tools/pip_package:build_pip_package
# bazel build -c opt --copt=-mavx --copt=-mavx2 --copt=-mfma --copt=-mfpmath=both -k //tensorflow/tools/pip_package:build_pip_package