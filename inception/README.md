```markdown
*This project has been created as part of the 42 curriculum by hamrachi.*

# Inception

## Description
This project is a System Administration exercise designed to deepen understanding of Docker, containerization, and infrastructure as code. The goal is to set up a small infrastructure composed of different services using **Docker Compose**.

The project involves building a complete stack from scratch (using specific Dockerfiles) consisting of:
* **Nginx**: Serving as the web server with TLS v1.2/v1.3.
* **WordPress**: Running with PHP-FPM, connected to a MariaDB database.
* **MariaDB**: Storing the website's data.

All services run in separate isolated containers, communicating via a custom Docker network, with data persistence managed through bind mounts stored on the host machine.

## Structure
```text
.
├── Makefile
├── README.md
├── USER_DOC.md
├── DEV_DOC.md
└── srcs
    ├── .env
    ├── docker-compose.yml
    └── requirements
        ├── mariadb
        │   ├── Dockerfile
        │   └── tools
        │       └── docker-entrypoint.sh
        ├── nginx
        │   ├── Dockerfile
        │   └── conf
        │       └── default.conf
        └── wordpress
            ├── Dockerfile
            └── tools
                └── docker-entrypoint.sh

```

##Instructions###Prerequisites* Docker Engine
* Docker Compose
* Make
* Root/Sudo privileges (required for bind mounts and volume management)

###Installation & Execution**Step 1: Clone the repository**

```bash
git clone <repository_url> inception
cd inception

```

**Step 2: Environment Configuration**
Create a `.env` file inside the `srcs/` directory. It must contain the following variables:

* `DOMAIN_NAME` (e.g., hamrachi.42.fr)
* `MYSQL_DATABASE`
* `MYSQL_USER`, `MYSQL_PASSWORD`, `MYSQL_ROOT_PASSWORD`
* `WP_ADMIN_USER`, `WP_ADMIN_PASSWORD`, `WP_ADMIN_EMAIL`
* `WP_USER`, `WP_USER_PASSWORD`, `WP_USER_EMAIL`

**Step 3: Build and Run**
Run the following command at the root (where the Makefile is):

```bash
make

```

*This will build the images using the configuration in `srcs/docker-compose.yml` and start the containers.*

**Step 4: Verify Status**
Check if containers are running and healthy:

```bash
docker ps

```

**Step 5: Stop the project**

```bash
make down

```

**Step 6: Clean everything (Destructive)**
To remove all containers, images, networks, and **delete all persistent data** from `/home/hamrachi/data/`:

```bash
make fclean

```

**Step 7: Access**
Open your browser and navigate to: `https://hamrachi.42.fr`

---

##Project Description & Design Choices###Base Image StrategyAll containers are built on **Debian**.

* **Reason:** Debian provides a stable, robust environment with extensive package support (`apt-get`), ensuring compatibility for services like MariaDB and PHP-FPM.

###Architecture* **Nginx:** Configured via `srcs/requirements/nginx/conf/default.conf` with a self-signed SSL certificate to serve traffic exclusively over HTTPS (443).
* **WordPress:** Installed via WP-CLI in the `docker-entrypoint.sh` script. It depends on MariaDB being "healthy" before starting.
* **MariaDB:** Initialized with a custom entrypoint script that handles secure installation and user creation.

###Storage (Bind Mounts)Per the project requirements, data persistence is handled via **Bind Mounts**:

* **Database Data:** `/home/hamrachi/data/mariadb`
* **WordPress Files:** `/home/hamrachi/data/wordpress`

###NetworkingA custom bridge network named `inception_net_hamrachi` is used. Only port 443 is exposed to the host; all other communication (DB, PHP) happens internally.

---

##Technical Comparisons###Virtual Machines vs Docker* **VMs:** Virtualize hardware and run a full OS (heavy, slow boot).
* **Docker:** Virtualizes the OS, sharing the kernel (lightweight, instant start).

###Secrets vs Environment Variables* **Env Variables:** Easy to use (via `.env`), but visible in inspection. Used in this project for simplicity as per instructions.
* **Docker Secrets:** Encrypted and mounted as files only for specific services. More secure but more complex.

###Docker Network vs Host Network* **Host Network:** No isolation, shares host IP, port conflicts.
* **Docker Network:** Isolated environment, private IPs, DNS resolution (used here).

###Docker Volumes vs Bind Mounts* **Docker Volumes:** Managed by Docker internals.
* **Bind Mounts:** Direct mapping to a specific host folder (used here to map to `/home/hamrachi/data/`).

---

##Resources & AI Usage###References* [Docker Compose Documentation](https://docs.docker.com/compose/)
* [Debian Package Management](https://wiki.debian.org/Apt)
* [Nginx SSL Configuration](https://nginx.org/en/docs/http/configuring_https_servers.html)
* [WP-CLI Documentation](https://make.wordpress.org/cli/)

###AI Usage StatementArtificial Intelligence was utilized in this project for:

* **Troubleshooting:** Analyzing Docker logs to identify issues with volume permissions and "Access Denied" loops in the database initialization.
* **Script Logic:** Refining `docker-entrypoint.sh` logic to correctly wait for MariaDB to be fully ready before WordPress attempts a connection.
* **Documentation:** Assisting in structuring this README, generating the User/Dev documentation files, and clarifying technical comparisons between VMs and Containers.