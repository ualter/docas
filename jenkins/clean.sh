#! /bin/bash
clear
echo "******************************"
echo "** Cleaning the Jenkins Image "
echo "******************************"
echo ""

clear
echo "--> Listing Containers"
docker ps -a
echo ""
id="$(docker ps -a -q)"
if [ -n "$id" ]
	then
		echo "Cleaning Container: ${id}"
		docker stop "${id}"
		echo "--> Cleaned"
		docker rm "${id}"
		echo "--> Erased"
		echo ""
fi		
echo "--> Listing Image"
docker images -q ujr/jenkins
id="$(docker images -q ujr/jenkins)"
echo "Cleaning Image: ${id}"
docker rmi "${id}"
echo ""
echo "Ready!"
echo ""
