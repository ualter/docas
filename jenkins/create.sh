#! /bin/bash
clear
echo "******************************"
echo "** Creating the Jenkins Image "
echo "******************************"
echo ""

echo "--> Creating Image Jenkins"
docker build -t ujr/jenkins . 
echo ""
echo "--> Creating Container Jenkins"
#docker run --rm -p=8080:8080 ujr/jenkins
docker run -d -p=8080:8080 ujr/jenkins
id="$(docker ps -a -q)"
echo "--> Tail Logs"
docker logs -f -t "${id}"
echo "Finish "
echo ""