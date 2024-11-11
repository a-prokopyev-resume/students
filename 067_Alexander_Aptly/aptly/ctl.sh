#/usr/bin/env bash

#set -x;

ScriptDir=$(dirname $(realpath "$0"));

source "$ScriptDir/variables";
mkdir -p $DataDir 2>&1 | cat > /dev/null;

MoreOptions=${@};

if ! dpkg -al | grep docker.io | grep runtime; then
	apt-get install -y docker.io;
fi;

docker stop aptly 2>&1 | cat > /dev/null; sleep 1s;
#docker run -ti --rm --privileged --name aptly -v $EtcDir:/etc/aptly -v $DataDir:/aptly-repo debian-aptly-ctl:v1b $MoreOptions;
docker run -ti --rm --privileged --name aptly -v $EtcDir:/etc/aptly -v $DataDir:/aptly-repo sanyo1234/debian-aptly-ctl:v2b $MoreOptions;
