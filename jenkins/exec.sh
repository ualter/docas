#! /bin/bash
id="$(docker ps -a -q)"
docker exec -i "${id}" /bin/bash