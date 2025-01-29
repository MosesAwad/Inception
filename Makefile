# Colors for prettier output
GREEN = \033[0;32m
RED = \033[0;31m
RESET = \033[0m

# Docker compose file path
COMPOSE_FILE = srcs/docker-compose.yml

# Data directory path (as specified in the subject)
DATA_PATH = /home/$(USER)/data

CONTAINER_NAME = nginx

# Target names
all: setup build up

# Create necessary directories and setup environment
setup:
	@printf "$(GREEN)Creating data directories...$(RESET)\n"
	@mkdir -p $(DATA_PATH)
	@mkdir -p $(DATA_PATH)/wordpress
	@mkdir -p $(DATA_PATH)/ssl-certs
	@mkdir -p $(DATA_PATH)/mariadb
	@printf "$(GREEN)Setup complete!$(RESET)\n"

# Build the Docker images
build:
	@printf "$(GREEN)Building Docker images...$(RESET)\n"
	@docker compose -f $(COMPOSE_FILE) build

# Start the containers
up:
	@printf "$(GREEN)Starting containers...$(RESET)\n"
	@docker compose -f $(COMPOSE_FILE) up -d

# Stop the containers
down:
	@printf "$(RED)Stopping containers...$(RESET)\n"
	@docker compose -f $(COMPOSE_FILE) down

# Stop and remove containers, networks, and volumes
clean: down
	@printf "$(RED)Cleaning up containers, networks, and volumes...$(RESET)\n"
	@docker compose -f $(COMPOSE_FILE) down -v
	@docker system prune -af

# Remove all data
fclean: clean
	@printf "$(RED)Warning: Next step will delete all your website configuration, PHP files, and database data!$(RESET)\n"
	@read -p "Do you wish to proceed? (yes/no): " choice && [ "$$choice" = "yes" ] && \
		printf "$(RED)Removing data directories...$(RESET)\n" && sudo rm -rf $(DATA_PATH) || \
		printf "$(YELLOW)Aborted. No files were removed.$(RESET)\n"


# Restart all services
re: fclean all

# Show container status
status:
	@docker compose -f $(COMPOSE_FILE) ps

# Show container logs
logs:
	@docker compose -f $(COMPOSE_FILE) logs

# Update /etc/hosts on host machine to point mawad.42.fr and www.mawad.42.fr to container's IP
update-hosts:
	@printf "$(GREEN)Updating /etc/hosts with container's IP for mawad.42.fr and www.mawad.42.fr...$(RESET)\n"
	@IP=$$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(CONTAINER_NAME)) && \
		if grep -q "mawad.42.fr" /etc/hosts; then \
			sudo sed -i "s/^.*mawad.42.fr$$/$$IP mawad.42.fr $$IP www.mawad.42.fr/" /etc/hosts; \
			printf "$(GREEN)Updated mawad.42.fr and www.mawad.42.fr entries in /etc/hosts.$(RESET)\n"; \
		else \
			echo "$$IP mawad.42.fr $$IP www.mawad.42.fr" | sudo tee -a /etc/hosts; \
			printf "$(GREEN)Added mawad.42.fr and www.mawad.42.fr entries to /etc/hosts.$(RESET)\n"; \
		fi

.PHONY: all setup build up down clean fclean re status logs