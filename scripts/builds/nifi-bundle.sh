#!/bin/bash

# Jump to the project directory for executing SBT commands
projDir="$(cd "$( dirname "${BASH_SOURCE[0]}" )/../.." && pwd)"
cd $projDir

# Variables
projVer=$(cat version.sbt | grep '".*"' -o)
nifiLibDir=$(find / -type d -path "/usr/*/nifi/lib" -print -quit)
nifiSh=$(find / -type f -wholename "/usr/*/nifi.sh" -print -quit)

echo "Building the trucking-nifi-bundle project and installing the compiled NiFi nar to NiFi.  NiFi will be restarted"
sbt nifiBundle/compile
cp -f $projDir/trucking-nifi-bundle/nifi-trucking-nar/target/nifi-trucking-nar-$projVer.nar $nifiLibDir
$nifiSh restart