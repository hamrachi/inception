# Minimal Makefile to build and run the stack from srcs/docker-compose.yml
COMPOSE_FILE=srcs/docker-compose.yml

.PHONY: all build up down clean

all: build up

build:
	docker compose -f $(COMPOSE_FILE) build

up:
	docker compose -f $(COMPOSE_FILE) up -d

down:
	docker compose -f $(COMPOSE_FILE) down

clean:
	docker compose -f $(COMPOSE_FILE) down --rmi all -v --remove-orphans

