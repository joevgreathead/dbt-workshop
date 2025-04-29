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

<details>
  <summary>dbt_workshop.yml</summary>
<pre>
version: 2

sources:
  - name: workshop_seed_data
    schema: dbt_workshop
    tables:
      - name: competitors
        description: "Table with source information on competitors"
</pre>
</details>

## Add the first model to normalize competitor data

Add the `normalized_competitors.yml` and `normalized_competitors.sql` files under `models/`.

<details>
  <summary>normalized_competitors.yml</summary>
<pre>
models:
  - name: normalized_competitors
    description: "Competitor data but normalized so it's all trimmed and lower cased"
    config:
      materialized: table
    columns:
      - name: id
        data_type: integer
        tests:
          - unique
          - not_null
      - name: name
        data_type: varchar
        tests:
          - not_null
      - name: street_address
        data_type: varchar
      - name: city
        data_type: varchar
      - name: state
        data_type: varchar
      - name: postal_code
        data_type: varchar
      - name: country
        data_type: varchar
      - name: created_at
        data_type: timestamp
      - name: updated_at
        data_type: timestamp
      - name: address_hash
        data_type: text
</pre>
</details>

<details>
  <summary>normalized_competitors.sql</summary>
<pre>
with normalized_competitors as (
  select
      id,
      lower(trim(name)) as name,
      lower(trim(street_address)) as street_address,
      lower(trim(city)) as city,
      lower(trim(state)) as state,
      lower(trim(postal_code)) as postal_code,
      lower(trim(country)) as country,
      created_at,
      updated_at
  from {{ source('workshop_seed_data', 'competitors') }}
)

select
  *,
  {{ dbt_utils.generate_surrogate_key([
            "name",
            "street_address",
            "city",
            "state",
            "postal_code",
            "country"
    ]) }} AS address_hash
from normalized_competitors
</pre>
</details>

Run dbt
```bash
dbt run
```

## Add the second model to build count of competitors by location

Add the `cities.yml` and `cities.sql` files under `models/`.

<details>
  <summary>cities.yml</summary>
<pre>
models:
  - name: cities
    description: "All the cities various competitors call home"
    config:
      materialized: incremental
    columns:
      - name: id
        data_type: integer
        tests:
          - unique
          - not_null
      - name: city_name
        data_type: varchar
        tests:
          - not_null
      - name: state_name
        data_type: varchar
        tests:
          - not_null
      - name: total_competitors
        data_type: integer
</pre>
</details>

<details>
  <summary>cities.sql</summary>
<pre>
{{
  config(
    unique_key=['city_name', 'state_name']
  )
}}

with aggregate_data as (
  select
    city as city_name,
    state as state_name,
    count(*) as total_competitors
  from {{ ref('normalized_competitors') }}
  group by 1, 2

  {% if is_incremental() %}
  union all

  select city_name, state_name, total_competitors
  from {{ this }}
  where (city_name, state_name) not in (
    select
      city,
      state
    from {{ ref('normalized_competitors') }}
  )
  {% endif %}
)

select
  city_name,
  state_name,
  sum(total_competitors) as total_competitors
from aggregate_data
group by 1, 2

</pre>
</details>

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

<details>
  <summary>competitor_citites.yml</summary>
<pre>
models:
  - name: competitor_cities
    description: "View used to look at the results of aggregate competitor data by city"
    config:
      materialized: view
</pre>
</details>

<details>
  <summary>competitor_citites.sql</summary>
<pre>
select
  initcap(city_name) as city_name,
  upper(state_name) as state_name,
  total_competitors
from {{ ref('cities') }}
order by total_competitors desc, state_name asc
</pre>
</details>

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
