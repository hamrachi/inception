DEVELOPER DOCUMENTATION
=======================

1. ENVIRONMENT SETUP
--------------------

[ Prerequisites ]
- OS: Linux (Debian/Ubuntu recommended)
- Tools: Docker Engine, Docker Compose, Make, Git
- Permissions: Root/Sudo access (required to create host data directories)

[ Configuration (.env) ]

The project requires a .env file in srcs/ to store sensitive credentials.
NOTE: This file is NOT included in the repository for security reasons.
ACTION REQUIRED: Create srcs/.env manually before running the project.

Required Variables:
- DOMAIN_NAME
- MYSQL_DATABASE
- MYSQL_USER, MYSQL_PASSWORD, MYSQL_ROOT_PASSWORD
- WP_ADMIN_USER, WP_ADMIN_PASSWORD, WP_ADMIN_EMAIL
- WP_USER, WP_USER_PASSWORD, WP_USER_EMAIL

2. BUILD & LAUNCH LIFECYCLE
---------------------------
The project uses a Makefile to automate Docker Compose operations.

[ Key Commands ]

1. Build & Start:
   make
   - Runs: docker compose -f srcs/docker-compose.yml up -d --build
   - Builds images from srcs/requirements/ Dockerfiles
   - Creates the network inception_net_hamrachi

2. Stop:
   make down
   - Stops containers and removes the network.

3. Full Cleanup (Destructive):
   make fclean
   - WARNING: This is destructive.
   - Removes all containers, images, and networks.
   - Deletes Data: Executes "rm -rf /home/hamrachi/data" to wipe the database.

3. CONTAINER MANAGEMENT
-----------------------
You can interact with the running containers using standard Docker commands:

- Shell Access:
  docker exec -it <container_name> /bin/bash

- Database CLI:
  docker exec -it mariadb mysql -u root -p

4. DATA PERSISTENCE & STORAGE
-----------------------------
Data is persisted on the Host machine using Bind Mounts.
This ensures data survives container removal.

[ Storage Map ]

Service    | Host Path (Bind Mount)           | Container Path
-----------|----------------------------------|----------------
MariaDB    | /home/hamrachi/data/mariadb      | /var/lib/mysql
WordPress  | /home/hamrachi/data/wordpress    | /var/www/html