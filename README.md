docker-hindsight
================

Hindsight stream processing docker container.


Build
-----

To create the image `bbinet/hindsight`, execute the following command in the
`docker-hindsight` folder:

    docker build -t bbinet/hindsight .

You can now push the new image to the public registry:
    
    docker push bbinet/hindsight


Run
---

The hindsight container will read its configuration from cfg file located in
the docker volume of your choice.

For example:

    $ docker pull bbinet/hindsight

    $ docker run --name hindsight \
        -v $(pwd)/config:/etc/hindsight \
        bbinet/hindsight
