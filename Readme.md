# Setup

Create a virtual env for the project
```bash
python3 -m venv dbt-workshop
```

Activate the virtual env
```bash
source dbt-workshop/bin/activate
```

Install DBT Core and the postgres adapter
```bash
pip install -r requirements.txt
```

Instal dbt packages
```bash
dbt deps
```

## Setup the database

Start the database
```bash
docker compose up
```

Create the new database
```bash
PGPASSWORD=postgres createdb -h 127.0.0.1 -p 9675 -U postgres dbt_workshop_dev
```

Load the starter data
```bash
PGPASSWORD=postgres psql -h localhost -p 9675 -U postgres -d dbt_workshop_dev -f ./data/setup.sql
```

## When you're done developing

Deactivate the virtual env
```bash
deactivate
```

# Working with models

## Add a source definition for the competitors table

Under `models/` add a `sources/` directory. Add the `dbt_workshop.yml` file to that directory.

## Add the first model to normalize competitor data

Add the `normalized_competitors.yml` and `normalized_competitors.sql` files under `models/`.

Run dbt
```bash
dbt run
```

## Add the second model to build count of competitors by location

Add the `cities.yml` and `cities.sql` files under `models/`.

Re-run dbt
```bash
dbt run
```

## Push new data to competitors and re-run models

Push additional data to the competitors table
```bash
PGPASSWORD=postgres psql -h localhost -p 9675 -U postgres -d dbt_workshop_dev -f ./data/additional_competitors.sql
```

Re-run dbt
```bash
dbt run
```

## Add a model to build a view

Add the `competitor_citites.yml` and `competitor_citites.sql` files under `models/`.

Re-run dbt
```bash
dbt run
```

You can now query the view to see the ordered and formalized output.

```sql
select * from dbt_workshop.competitor_cities
```

## Build the docs and view them

Build the docs from the current model state.
```bash
dbt docs generate
```

Run the docs server and view them in the browser. Make sure to click on the graph icon in the bottom right.
```bash
dbt docs serve
```
