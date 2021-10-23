#!/bin/sh
# ==============================================================================================================
# SDKMAN! installs
# - Latest Java version
# - Latest Maven version
# - Latest Gradle version
# ==============================================================================================================

echo "Installing Java ..."
sdk install java

echo "Installing Maven ..."
sdk install maven

echo "Installing Gradle ..."
sdk install gradle

echo $M2_HOME
mvn --version

echo $GRADLE_HOME
gradle --version

echo $JAVA_HOME
java --version