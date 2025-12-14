```markdown
# User Documentation

## 1. Overview
This infrastructure stack provides a complete WordPress website environment. It consists of three integrated services:
* **WordPress:** The content management system where you manage your website.
* **MariaDB:** The database that securely stores your content and user data.
* **Nginx:** The secure web server that handles visitor traffic via HTTPS.

## 2. Managing the Project
To manage the infrastructure, open a terminal in the project folder and use the following commands:

### Starting the Stack
To start the website:
```bash
make

```

*Wait approximately 30-60 seconds for the database to initialize.*

###Stopping the StackTo stop the website and free up resources:

```bash
make down

```

##3. Accessing the WebsiteOnce the stack is running, you can access the services via your web browser:

* **Website URL:** [https://hamrachi.42.fr](https://hamrachi.42.fr)
* **Admin Panel:** [https://hamrachi.42.fr/wp-admin](https://www.google.com/search?q=https://hamrachi.42.fr/wp-admin)
*Note: You may encounter a security warning because we use a self-signed certificate. You must accept the risk to proceed.*

##4. CredentialsFor security reasons, usernames and passwords are **not** hardcoded. They are located in a hidden configuration file:

* **Location:** `srcs/.env`
* **How to view:** Run `cat srcs/.env` in the terminal.

Look for variables starting with `WP_ADMIN_` to find your administrator login details.

##5. Basic Health ChecksTo verify that the system is running correctly:

**Check Status**
Run `docker ps`. You should see 3 containers (`nginx`, `wordpress`, `mariadb`) listed as "Up" and "healthy".

**Check Logs**
If the site is unreachable, check the logs with:

```bash
docker logs wordpress
docker logs mariadb

```