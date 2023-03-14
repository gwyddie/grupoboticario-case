ifneq (,$(wildcard ./.env))
	include .env
	export
endif

prep-env:
	@cd airflow && mkdir -p dags logs plugins
	@cp .env-example .env
	@echo "AIRFLOW_UID=`id -u`" >> .env
	@docker compose build

test:
	@cd airflow/dags && python -m pytest ..

ci:
	@gsutil -m rsync -d -r resources gs://${GS_BUCKET}/resources
