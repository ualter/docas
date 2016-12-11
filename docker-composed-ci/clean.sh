#! /bin/bash
clear
echo ""
echo "******************************************************"
echo "** Cleaning the Docker Composed Continous Integration "
echo "******************************************************"

echo "Are you sure you want start all over again? (s/n)"; 
read answer
if [ "$answer" == "n" ] || [ "$answer" == "N" ];
then
	clear
    echo ""
    echo "Ok! - Nothing was done."
    echo ""
	exit
fi

if [ "$answer" == "s" ] || [ "$answer" == "S" ];
then
	echo ""
	echo "OK, let's do it..."
	echo ""
	echo "***********************************************"
	echo "** Dealing with the Composed CONTAINERs Created"
	echo "***********************************************"
	# Looking for Composed Containers Created and Remove them
	index=0
	while read -r line || [[ -n $line ]]
	do
		(( index++ ))
		if [ $index -gt 1 ]; then
			columns=($line)
			lastColumn=${#columns[@]}-1
			containerId=${columns[0]}
			containerName=${columns[$lastColumn]}
			echo "Stoping....:("$containerId" - "$containerName")"
			docker stop $containerId
			echo "Removing...:("$containerId" - "$containerName")"
			docker rm $containerId
		fi	
	done < <(docker ps -a)	
	
	# Clean Home Jenkins (for starting fresh)
	rm -rf ../jenkins/home/*
	
	echo "***********************************************"
	echo "** Dealing with the Composed IMAGEs Created"
	echo "***********************************************"
	
	composeNameSufix="dockercomposedci"
	docker rmi $composeNameSufix"_nexus"
	docker rmi $composeNameSufix"_sonarqube"
	docker rmi $composeNameSufix"_jenkins"
	docker rmi $composeNameSufix"_wildfly"
	# Looking for Composed Images Created and Remove them
	#while read -r line
	#do
	#	columns=($line)
	#	imageName=${columns[0]}
	#	imageId=${columns[2]}
	#	echo "Removing...:("$imageId" - "$imageName")"
	#	docker rmi $imageId
	#done < <(docker images | grep 'dockercomposedci_')
	
	echo "***********"
	echo "** Done! **"
	echo "***********"
fi




