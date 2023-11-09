#!/bin/bash
set -ex

# fetch_source() - $1 as version
build_rpm() {
  echo "Creating setup tree"
  sudo -u rpmbuilder rpmdev-setuptree
  ls /home/rpmbuilder
  echo "Downloading Warewulf ${1}"
  sudo -u rpmbuilder wget -q "https://github.com/hpcng/warewulf/releases/download/v${1}/warewulf-${1}.tar.gz" -O /tmp/warewulf-${1}.tar.gz
  echo "Extracting warewulf-${1}.tar.gz"
  sudo -u rpmbuilder tar xf /tmp/warewulf-${1}.tar.gz -C /tmp
  echo "Copying warewulf-${1}.tar.gz to /home/rpmbuilder/rpmbuild/SOURCES"
  sudo -u rpmbuilder cp /tmp/warewulf-${1}.tar.gz /home/rpmbuilder/rpmbuild/SOURCES/warewulf-${1}.tar.gz
  echo "Copying SPEC file to /home/rpmbuilder/rpmbuild/SPECS"
  sudo -u rpmbuilder cp /tmp/warewulf-4.4.1/warewulf.spec /home/rpmbuilder/rpmbuild/SPECS/warewulf.spec
  ls /home/rpmbuilder/rpmbuild/SPECS
  ls /home/rpmbuilder/rpmbuild/SOURCES
  echo "Building warewulf v${1}"
  sudo -u rpmbuilder rpmbuild -bb /home/rpmbuilder/rpmbuild/SPECS/warewulf.spec
  ls /home/rpmbuilder/rpmbuild/*
}


copy_output() {
  echo "Moving built RPM to local system"
  cp /home/rpmbuilder/rpmbuild/RPMS/x86_64/* /tmp/output
}

###### RUN RPM BUILD PROCEDURE ######
build_rpm "$WAREWULF_VERSION"
copy_output
