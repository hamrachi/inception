COMPOSE_FILE=srcs/docker-compose.yml

.PHONY: all build up down clean

all: build

build:
	docker compose -f $(COMPOSE_FILE) up -d --build

down:
	docker compose -f $(COMPOSE_FILE) down

clean:
	docker compose -f $(COMPOSE_FILE) down --rmi all -v --remove-orphans

fclean: clean
	docker volume prune -f
	docker system prune -af
	docker network prune -f
	sudo rm -rf /home/hamrachi/data/wordpress/* /home/hamrachi/data/mariadb/*

re: fclean all