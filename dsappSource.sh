#!/bin/bash

if [ -z "$1" ];then
   echo "You didn't specify anything to build";
   exit 1;
fi

# delete older versions of the rpm since there's no point having old 
# versions in there when we still have the src.rpms in the SRPMS dir
find /usr/src/packages/RPMS -name ${1}-[0-9]\* -exec rm -f {} \;
find /usr/src/packages/noarch -name ${1}-[0-9]\* -exec rm -f {} \;

cd /usr/src/packages/SOURCES/
cp /root/Desktop/dsapp/dsapp-test.sh ./dsapp.sh
cp /usr/code/dsapp/filestoreIdToPath.pyc ./

# build the package
dos2unix /home/rpmbuild/rpmbuild/SPECS/${1}.spec
su rpmbuild -c "rpmbuild -ba /home/rpmbuild/rpmbuild/SPECS/${1}.spec"

cp /usr/src/packages/RPMS/noarch/dsapp*.rpm /root/Desktop/dsapp/
cd /root/Desktop/dsapp/
cp dsapp-rpm.sh dsapp.sh
tar czf dsapp.tgz dsapp*.rpm dsapp.sh
