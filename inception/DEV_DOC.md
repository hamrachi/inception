```markdown
# Developer Documentation

## 1. Environment Setup

### Prerequisites
* **OS:** Linux (Debian/Ubuntu recommended)
* **Tools:** Docker Engine, Docker Compose, Make, Git.
* **Permissions:** Root/Sudo access is required to create the host data directories.

### Configuration (`.env`)
The project requires a `.env` file in `srcs/` to store sensitive credentials.
**Note:** This file is NOT included in the repository for security reasons.
**Action Required:** Create `srcs/.env` manually before running the project.

**Required Variables:**
* `DOMAIN_NAME`
* `MYSQL_DATABASE`, `MYSQL_USER`, `MYSQL_PASSWORD`, `MYSQL_ROOT_PASSWORD`
* `WP_ADMIN_USER`, `WP_ADMIN_PASSWORD`, `WP_ADMIN_EMAIL`
* `WP_USER`, `WP_USER_PASSWORD`, `WP_USER_EMAIL`

## 2. Build & Launch Lifecycle
The project uses a `Makefile` to automate Docker Compose operations.

### Key Commands

**Build & Start:** `make`
* *Under the hood:* Runs `docker compose -f srcs/docker-compose.yml up -d --build`.
* It builds images from the `srcs/requirements/` Dockerfiles.
* It creates the network `inception_net_hamrachi`.

**Stop:** `make down`
* Stops containers and removes the network.

**Full Cleanup:** `make fclean`
* **Warning:** This is destructive.
* Removes all containers, images, and networks.
* **Deletes Data:** Executes `rm -rf /home/hamrachi/data` to wipe the database and website files.

## 3. Container Management
You can interact with the running containers using standard Docker commands:
* **Shell Access:** `docker exec -it <container_name> /bin/bash`
* **Database CLI:** `docker exec -it mariadb mysql -u root -p`

## 4. Data Persistence & Storage
Data is persisted on the Host machine using **Bind Mounts**. This ensures data survives container removal.

| Service   | Host Path (Bind Mount)         | Container Path   |
|-----------|--------------------------------|------------------|
| MariaDB   | `/home/hamrachi/data/mariadb`  | `/var/lib/mysql` |
| WordPress | `/home/hamrachi/data/wordpress`| `/var/www/html`  |