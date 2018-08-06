docker ps -q | xargs docker stop rm
docker ps -a -q | xargs docker rm 

