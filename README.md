# Vector db example

## Locally hosted db

The database and application are deployed in separate containers. This is motivated by separation of concerns, making deployment more modular and easier to manage. Additionally, it is more flexible as the database can be altered/updated/swapped without any changes to the application containers.

In order to host the database locally, we first need to build the docker image for the postgres database.
1. ``cd db/``
2. ``docker build . -t db_image``
3. Run the container, forwarding tcp inputs to port 5433 of the host machine to 5432 (specified by the postgres base image) of the container. Furthermore, in order for database state to persist between ephemeral container instances, we need to use an external volume on the host machine. This is achieved using the named volume "pgdata". ``docker run -p 5433:5432 -v pgdata:/var/lib/postgresql/data -d db_image``

If this is the first time the database is hosted locally, we need to create a database on this server:
1. ``psql -U postgres -p 5433 -h localhost``
2. ``createdb "my_db"``

## Cloud Hosted db

## Application

Building the application:
1. ``docker build . -t app_image``
2. ``docker run --net=host app_image``

For running locally, we need to define the network for the container to be that of the host machine, otherwise the virtual localhost in the application container will not be able to see the locally hosted database.
