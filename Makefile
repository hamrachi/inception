COMPOSE_FILE=srcs/docker-compose.yml

.PHONY: all build up down clean fclean re

all: build

build:
	# Create the data folders on the host machine first
	mkdir -p /home/hamrachi/data/mariadb
	mkdir -p /home/hamrachi/data/wordpress
	docker compose -f $(COMPOSE_FILE) up -d --build

down:
	docker compose -f $(COMPOSE_FILE) down

clean:
	docker compose -f $(COMPOSE_FILE) down --rmi all -v --remove-orphans

fclean: clean
	docker volume prune -f
	docker system prune -af
	docker network prune -f
	# Clean the data folders (sudo is required because Docker writes as root)
	sudo rm -rf /home/hamrachi/data

re: fclean all