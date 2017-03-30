# ----------------------------------------------------------------------------
#
# Package	: clearNLP
# Version	: 3.2.0
# Source repo	: https://github.com/clir/clearnlp
# Tested on	: ubuntu_16.04
# Script License: Apache License, Version 2 or later
# Maintainer	: Atul Sowani <sowania@us.ibm.com>
#
# Disclaimer: This script has been tested in non-root mode on given
# ==========  platform using the mentioned version of the package.
#             It may not work as expected with newer versions of the
#             package and/or distribution. In such case, please
#             contact "Maintainer" of this script.
#
# ----------------------------------------------------------------------------

#!/bin/bash

# Install dependencies.
sudo apt-get update -y
sudo apt-get install -y build-essential g++ ant wget git \
    software-properties-common openjdk-8-jdk openjdk-8-jre

WORKDIR=`pwd`

export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-ppc64el
export PATH=$PATH:$JAVA_HOME/bin

wget http://archive.apache.org/dist/maven/maven-3/3.3.3/binaries/apache-maven-3.3.3-bin.tar.gz
tar -zxf apache-maven-3.3.3-bin.tar.gz
sudo cp -R apache-maven-3.3.3 /usr/local
sudo ln -s /usr/local/apache-maven-3.3.3/bin/mvn /usr/bin/mvn
mvn --version

# Build clearNLP.
cd $WORKDIR
git clone https://github.com/clir/clearnlp
cd clearnlp
mvn dependency:list -DexcludeTransitive
mvn -DskipTests package && mvn test -fn
