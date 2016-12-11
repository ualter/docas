#! /bin/bash
clear
echo ""
echo "*****************************"
echo "** Building the Dockers      "
echo "*****************************"
echo ""


# Getting the docker-machine IP address
activeMachine=$(docker-machine active)
ip=$(docker-machine ip $activeMachine)
echo "You are at the...: \"$activeMachine\" machine"
echo "Your IP is.......: \"$ip\""
echo ""

# Replacing the NEXUS, SONAR URL address at the Config Files
# for the correspondent virtual machine (default) IP local address
jenkinsDir="../jenkins/config"
cp $jenkinsDir/maven-global-settings-files.xml.original $jenkinsDir/maven-global-settings-files.xml
echo "Configuring Jenkins config files with the $ip docker-machine address, for:"
fileToChangeIp="maven-global-settings-files.xml"
echo "NEXUS at http://$ip:8081"
sed -i.bak s/http:\\/\\/nexus/http:\\/\\/$ip/g $jenkinsDir/$fileToChangeIp
echo "SONAR at http://$ip:9000"
sed -i.bak s/http:\\/\\/sonar/http:\\/\\/$ip/g $jenkinsDir/$fileToChangeIp
rm $jenkinsDir/$fileToChangeIp.bak
sonarConfigFile="../jenkins/config/hudson.plugins.sonar.SonarGlobalConfiguration.xml" 
cp "$sonarConfigFile.original" $sonarConfigFile
sed -i.bak s/http:\\/\\/sonar/http:\\/\\/$ip/g $sonarConfigFile
rm "$sonarConfigFile.bak"
echo ""

# Getting Up the Dockers (creating if not exist them yet)
echo "--> Start building"
docker-compose up -d
echo ""

# Show the Logging
echo "--> Listing the Running Containers"
echo "ID	NAME	PORTS"
docker ps --format "{{.ID}}\t{{.Names}}\t{{.Ports}}"
echo ""
echo "Show the logs with the comand: \"docker logs -f [container Id]\""
echo ""
echo "***********"
echo "** Done! **"
echo "***********"
echo ""