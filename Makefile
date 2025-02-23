DOCKER_COMPOSE_FILE = srcs/docker-compose.yml

.PHONY: up down build stop ps logs restart clean help

up:
	docker compose -f $(DOCKER_COMPOSE_FILE) up -d
	mkdir -p	/home/zachamou/data

down:
	docker compose -f $(DOCKER_COMPOSE_FILE) down -v
	sudo rm -rf /home/zachamou/data

build:
	docker compose -f $(DOCKER_COMPOSE_FILE) build

stop:
	docker compose -f $(DOCKER_COMPOSE_FILE) stop

ps:
	docker compose -f $(DOCKER_COMPOSE_FILE) ps

logs:
	docker compose -f $(DOCKER_COMPOSE_FILE) logs -f

restart:
	docker compose -f $(DOCKER_COMPOSE_FILE) restart

clean:
	docker image prune -f

help:
	@echo "Makefile pour gérer docker-compose.yml"
	@echo ""
	@echo "Cibles disponibles:"
	@echo "  up       - Démarrer les services"
	@echo "  down     - Arrêter et supprimer les conteneurs et leurs volumes"
	@echo "  build    - Construire les images"
	@echo "  stop     - Arrêter les conteneurs"
	@echo "  ps       - Afficher les conteneurs en cours d'exécution"
	@echo "  logs     - Afficher les logs des conteneurs"
	@echo "  restart  - Redémarrer les services"
	@echo "  clean    - Supprimer les images non utilisées"
	@echo "  help     - Afficher cette aide"