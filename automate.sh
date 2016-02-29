docker stop  mauti
docker rm mautic
docker build -t mautic .
docker run -d -p 80:80 --name mautic-r mautic
docker exec -it mautic-r /bin/bash
