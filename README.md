```markdown
*This project has been created as part of the 42 curriculum by hamrachi.*

INCEPTION
=========

--------------
1. DESCRIPTION

This project is a System Administration exercise designed to deepen
understanding of Docker, containerization, and infrastructure as code.
The goal is to set up a small infrastructure composed of different
services using Docker Compose.

The project involves building a complete stack from scratch consisting of:

- Nginx:
  Serving as the web server with TLS v1.2/v1.3.

- WordPress:
  Running with PHP-FPM, connected to a MariaDB database.

- MariaDB:
  Storing the website's data.

All services run in separate isolated containers, communicating via a
custom Docker network, with data persistence managed through bind mounts
stored on the host machine.

------------
2. STRUCTURE

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

---------------
3. INSTRUCTIONS

[ Prerequisites ]
- Docker Engine
- Docker Compose
- Make
- Root/Sudo privileges

[ Installation & Execution ]

Step 1: Clone the repository
   git clone <repository_url> inception
   cd inception

Step 2: Environment Configuration
   Create a .env file inside the srcs/ directory.
   It must contain the following variables:
   - DOMAIN_NAME
   - MYSQL_DATABASE
   - MYSQL_USER, MYSQL_PASSWORD, MYSQL_ROOT_PASSWORD
   - WP_ADMIN_USER, WP_ADMIN_PASSWORD, WP_ADMIN_EMAIL
   - WP_USER, WP_USER_PASSWORD, WP_USER_EMAIL

Step 3: Build and Run
   make
   (Builds images and starts the containers in the background)

Step 4: Verify Status
   docker ps

Step 5: Stop the project
   make down

Step 6: Clean everything (Destructive)
   make fclean
   (WARNING: Deletes all containers, images, and database data)

Step 7: Access
   Open your browser and navigate to: https://hamrachi.42.fr

---------------------------
4. PROJECT DESIGN & CHOICES

[ Base Image Strategy ]

All containers are built on Debian.
- Reason: Debian provides a stable, robust environment with extensive
  package support (apt-get), ensuring compatibility for services.

[ Architecture ]

- Nginx:
  Configured with a self-signed SSL certificate to serve traffic
  exclusively over HTTPS (443).

- WordPress:
  Installed via WP-CLI. It waits for MariaDB to be "healthy"
  before attempting to start.

- MariaDB:
  Initialized with a custom script that handles secure installation
  and user creation.

[ Storage (Bind Mounts) ]

Data persistence is handled via Bind Mounts on the host:
- Database:  /home/hamrachi/data/mariadb
- WordPress: /home/hamrachi/data/wordpress

[ Networking ]

A custom bridge network (inception_net_hamrachi) is used.
Only port 443 is exposed to the host.

------------------------
5. TECHNICAL COMPARISONS

[ Virtual Machines vs Docker ]

- VMs: Virtualize hardware, run a full OS, heavy, slow boot.
- Docker: Virtualizes the OS, shares the kernel, lightweight, instant start.

[ Secrets vs Environment Variables ]

- Env Variables: Easy to use (.env), but visible in inspection.
- Docker Secrets: Encrypted files, more secure, but more complex setup.

[ Docker Network vs Host Network ]

- Host Network: No isolation, shares host IP, port conflicts.
- Docker Network: Isolated environment, private IPs, DNS resolution.

[ Docker Volumes vs Bind Mounts ]

- Docker Volumes: Managed by Docker internals (opaque).
- Bind Mounts: Direct mapping to a specific host folder (transparent).

-----------------------
6. RESOURCES & AI USAGE

[ References ]

- Docker Compose Documentation
- Debian Package Management (Wiki)
- Nginx SSL Configuration
- WP-CLI Documentation

[ AI Usage Statement ]

Artificial Intelligence was utilized in this project for:
- Troubleshooting: Analyzing Docker logs to identify issues with
  volume permissions and database initialization loops.
- Script Logic: Refining the entrypoint script to correctly wait
  for MariaDB availability.
- Documentation: Structuring this README and clarifying the
  technical comparisons between VMs and Containers.

```