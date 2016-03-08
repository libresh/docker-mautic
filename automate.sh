docker stop  mautic-rn
docker rm mautic-rn
docker build -t mautic .
docker run -d -p 80:80 --name mautic-rn mautic
docker exec -it mautic-rn /bin/bash
