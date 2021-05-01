#!/bin/bash


containerName=$1
dockerImageTag=$2
portMapping=$3

# delete unused images
docker image prune -f

# check for existing container
containerId=$(docker ps -a -q --filter name=${containerName})
echo "container Id: ${containerId}"
if [[ ${containerId} ]];then
	echo "Is running ..."
	docker kill ${containerId} > /dev/null 2>&1
	docker rm ${containerId} > /dev/null 2>&1
	docker run -e BACKEND_API_URL=http://192.168.1.145:18765 --network=ibdaa_network --name ${containerName} -p ${portMapping} -d ${dockerImageTag}
else
	docker run -e BACKEND_API_URL=http://192.168.1.145:18765 --network=ibdaa_network --name ${containerName} -p ${portMapping} -d ${dockerImageTag}
fi
