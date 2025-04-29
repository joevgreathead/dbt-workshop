create database if not exists dbt_workshop_dev;

create schema if not exists dbt_workshop;

create table if not exists dbt_workshop.competitors (
    id serial primary key,
    name varchar(100) not null,
    street_address varchar(200),
    city varchar(100),
    state varchar(50),
    postal_code varchar(20),
    country varchar(100),
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp
);

INSERT INTO dbt_workshop.competitors (name, street_address, city, state, postal_code, country)
SELECT 'Acme Corp', '123 Main St', 'Los Angeles', 'CA', '90001', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM dbt_workshop.competitors WHERE name = 'Acme Corp');

INSERT INTO dbt_workshop.competitors (name, street_address, city, state, postal_code, country) 
SELECT 'Global Industries', '456 Business Ave', 'New York', 'NY', '10001', 'USA'
WHERE NOT EXISTS (SELECT 1 FROM dbt_workshop.competitors WHERE name = 'Global Industries');

INSERT INTO dbt_workshop.competitors (name, street_address, city, state, postal_code, country)
SELECT 'Tech Solutions Ltd', '789 Innovation Dr', 'San Francisco', 'CA', '94105', 'USA' 
WHERE NOT EXISTS (SELECT 1 FROM dbt_workshop.competitors WHERE name = 'Tech Solutions Ltd');
