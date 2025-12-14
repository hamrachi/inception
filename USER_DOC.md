USER DOCUMENTATION
==================

1. OVERVIEW
-----------
This infrastructure stack provides a complete WordPress website environment.
It consists of three integrated services:

- WordPress:
  The content management system where you manage your website.

- MariaDB:
  The database that securely stores your content and user data.

- Nginx:
  The secure web server that handles visitor traffic via HTTPS.

2. MANAGING THE PROJECT
-----------------------
To manage the infrastructure, open a terminal in the project folder
and use the following commands:

[ Starting the Stack ]
Command: make
- Action: Builds the system and starts the website.
- Note: Wait approximately 30-60 seconds for the database to initialize.

[ Stopping the Stack ]
Command: make down
- Action: Stops the website and frees up resources.

3. ACCESSING THE WEBSITE
------------------------
Once the stack is running, you can access the services via your web browser:

- Website URL:
  https://hamrachi.42.fr

- Admin Panel:
  https://hamrachi.42.fr/wp-admin

(Note: You may encounter a security warning because we use a self-signed
certificate. You must accept the risk to proceed.)

4. CREDENTIALS
--------------
For security reasons, usernames and passwords are NOT hardcoded.
They are located in a hidden configuration file.

- Location: srcs/.env
- How to view: Run "cat srcs/.env" in the terminal.

Look for variables starting with "WP_ADMIN_" to find your administrator
login details.

5. BASIC HEALTH CHECKS
----------------------
To verify that the system is running correctly:

[ Check Status ]
Command: docker ps
- Expected Output: You should see 3 containers (nginx, wordpress, mariadb)
  listed as "Up" and "healthy".

[ Check Logs ]
If the site is unreachable, check the logs with:
- docker logs wordpress
- docker logs mariadb