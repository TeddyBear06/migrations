# Utiliser sql-migrate

## Prérequis

- Go v1.17.7 :

```bash
wget https://go.dev/dl/go1.17.7.linux-amd64.tar.gz
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf go1.17.7.linux-amd64.tar.gz
rm go1.17.7.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
go version
go env GOPATH
export PATH=$PATH:/home/bob/go/bin
```

- Golang migrate :

```bash
go install -tags 'sqlserver' github.com/golang-migrate/migrate/v4/cmd/migrate@latest
```

- Lancer une instance MSSQL locale (si vous n'en avez pas déjà une) :

```bash
docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=WootWoot123!" -p 1533:1433 -d mcr.microsoft.com/mssql/server:2019-CU15-ubuntu-20.04
```

## Quickstart

1. Générer les migrations initiales :

```bash
migrate create -ext sql -dir migrations/initials create_demo_schema
migrate create -ext sql -dir migrations/initials create_configurations_table
```

2.  Générer les migrations communes :

```bash
migrate create -ext sql -dir migrations/commons create_articles_table
migrate create -ext sql -dir migrations/commons create_some_articles_view
migrate create -ext sql -dir migrations/commons create_client_articles_synonym
```

Remplissez les migrations.

3. Exécuter les migrations :

Créer la base de données *mydb* et *clientdb* (si ce n'est pas déjà fait), puis :

```bash
source .env
migrate -path migrations/initials -database ${MIGRATE_DSN_INITIAL} up
# Uniquement la première migration pour configurer le client
migrate -path migrations/specifics/acme -database ${MIGRATE_DSN_CLIENT} up 1
# Toutes les migrations du tronc commun
migrate -path migrations/commons -database ${MIGRATE_DSN_COMMON} up
```

4. Générer une migration spécifique :

```bash
migrate create -ext sql -dir migrations/specifics/acme alter_some_articles_view
```

5. Exécuter la migration :

```bash
migrate -path migrations/specifics/acme -database ${MIGRATE_DSN_CLIENT} up
```