docker-build:
	@cd builder && docker-compose build --parallel

docker-down:
	@cd builder && docker-compose down

docker-build-packages: docker-build
	@cd builder && docker-compose up

docker-shell:
	@cd builder && docker-compose run --entrypoint /bin/bash rhel-9

.PHONY: docker-build docker-down docker-build-packages docker-shell
