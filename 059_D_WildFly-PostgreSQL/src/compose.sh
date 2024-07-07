#!/usr/bin/env bash

#=============================================== The Beginning of the Copyright Notice ===================================================
# The AUTHOR of this file and the owner of all exclusive rights in this file is Alexander Borisovich Prokopyev
# born on December 20, 1977 resident of the city of Kurgan, Russia;
# Series and Russian passport number of the AUTHOR (only the last two digits for each one): **22-****91
# Russian Individual Taxpayer Number of the AUTHOR (only the last four digits): ********2007
# Russian Insurance Number of Individual Ledger Account of the AUTHOR (only the last five digits): ***-***-859 04
# Copyright (C) Alexander B. Prokopyev, 2024, All Rights Reserved.
# Contact of the AUTHOR: a.prokopyev.resume at gmail dot com
# WWW: https://github.com/a-prokopyev-resume/students
#
# All source code and other content contained in this file is protected by copyright law.
# This file is licensed by the AUTHOR under AGPL v3 (GNU Affero General Public License): https://www.gnu.org/licenses/agpl-3.0.en.html
#
# THIS FILE IS LICENSED ONLY PROVIDED FOLLOWING RESTRICTIONS ALSO APPLY:
# Nobody except the AUTHOR may alter or remove this copyright notice from any copies of this file content (including modified fragments).
# Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. 
#
# ATTENTION: If potential user's or licensee's country laws collide or are not compatible with the terms of this copyright notice or 
# if a potential user or licensee does not agree with the terms of this copyright notice then such potential user or licensee  
# is STRONGLY PROHIBITED to use this file by any method.
#================================================== The End of the Copyright Notice ======================================================

set -x;

ComposeEnv=" --env-file=env/docker-compose.env --env-file=env/super.env ";

#env2json;

Action=$1;

MoreArgs="${@:2}";

clean_stopped()
{
	docker system prune -f;
}

echo -e "\n\n\n===> Debug at $(date):";
case $Action in
	( start )
		Services="$MoreArgs";
		Options=" -d";
		(set -x; docker-compose $ComposeEnv -f /download/docker-compose.yml up $Options $Services); #--no-deps
	;;

	( stop )
		Services="$MoreArgs";
		(set -x; docker-compose $ComposeEnv stop $Services);
		clean_stopped;
	;;
	
	( restart )
		./compose.sh stop;
        	./compose.sh start;
        	./compose.sh logs;
	;;
	( clean )
		clean_stopped;
	;;

	( inspect )
		Containers="$MoreArgs";
		for C in $Containers; do
			(set -x; docker inspect $C) | grep -i env -A 10;
		done;
	;;
	
	( logs )
		(set -x; docker-compose $ComposeEnv logs  $Services);
	;;
esac;
docker ps -a;
