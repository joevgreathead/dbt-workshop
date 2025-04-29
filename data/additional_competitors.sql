INSERT INTO dbt_workshop.competitors (name, street_address, city, state, postal_code, country) 
SELECT 'Summit Learning Academy', '742 Summit Ridge', 'Boulder', 'Colorado', '80302', 'USA'
WHERE NOT EXISTS (
    SELECT 1 FROM dbt_workshop.competitors 
    WHERE name = 'Summit Learning Academy' 
    AND street_address = '742 Summit Ridge'
);

INSERT INTO dbt_workshop.competitors (name, street_address, city, state, postal_code, country)
SELECT 'Knowledge Tree Institute', '123 Main Street', 'Boston', 'Massachusetts', '02108', 'USA'
WHERE NOT EXISTS (
    SELECT 1 FROM dbt_workshop.competitors 
    WHERE name = 'Knowledge Tree Institute'
    AND street_address = '123 Main Street'
);

INSERT INTO dbt_workshop.competitors (name, street_address, city, state, postal_code, country)
SELECT 'Breakthrough Tutoring Center', '555 Strength Ave', 'Austin', 'Texas', '78701', 'USA'
WHERE NOT EXISTS (
    SELECT 1 FROM dbt_workshop.competitors 
    WHERE name = 'Breakthrough Tutoring Center'
    AND street_address = '555 Strength Ave'
);

INSERT INTO dbt_workshop.competitors (name, street_address, city, state, postal_code, country)
SELECT 'Elite Academic Prep', '890 Fitness Blvd', 'Boston', 'Massachusetts', '02108', 'USA'
WHERE NOT EXISTS (
    SELECT 1 FROM dbt_workshop.competitors 
    WHERE name = 'Elite Academic Prep'
    AND street_address = '890 Fitness Blvd'
);

INSERT INTO dbt_workshop.competitors (name, street_address, city, state, postal_code, country)
SELECT 'Mindful Learning Center', '234 Muscle Lane', 'Las Vegas', 'Nevada', '89101', 'USA'
WHERE NOT EXISTS (
    SELECT 1 FROM dbt_workshop.competitors 
    WHERE name = 'Mindful Learning Center'
    AND street_address = '234 Muscle Lane'
);

INSERT INTO dbt_workshop.competitors (name, street_address, city, state, postal_code, country)
SELECT 'Excellence Education Academy', '467 Marathon Way', 'Boston', 'Massachusetts', '02108', 'USA'
WHERE NOT EXISTS (
    SELECT 1 FROM dbt_workshop.competitors 
    WHERE name = 'Excellence Education Academy'
    AND street_address = '467 Marathon Way'
);

INSERT INTO dbt_workshop.competitors (name, street_address, city, state, postal_code, country)
SELECT 'Core Knowledge School', '789 Balance Road', 'Seattle', 'Washington', '98101', 'USA'
WHERE NOT EXISTS (
    SELECT 1 FROM dbt_workshop.competitors 
    WHERE name = 'Core Knowledge School'
    AND street_address = '789 Balance Road'
);

INSERT INTO dbt_workshop.competitors (name, street_address, city, state, postal_code, country)
SELECT 'Peak Academic Institute', '321 Victory Drive', 'Denver', 'Colorado', '80202', 'USA'
WHERE NOT EXISTS (
    SELECT 1 FROM dbt_workshop.competitors 
    WHERE name = 'Peak Academic Institute'
    AND street_address = '321 Victory Drive'
);

INSERT INTO dbt_workshop.competitors (name, street_address, city, state, postal_code, country)
SELECT 'Scholars Success Center', '159 Iron Street', 'Seattle', 'Washington', '98101', 'USA'
WHERE NOT EXISTS (
    SELECT 1 FROM dbt_workshop.competitors 
    WHERE name = 'Scholars Success Center'
    AND street_address = '159 Iron Street'
);

INSERT INTO dbt_workshop.competitors (name, street_address, city, state, postal_code, country)
SELECT 'Bright Future Academy', '753 Health Avenue', 'Seattle', 'Washington', '98101', 'USA'
WHERE NOT EXISTS (
    SELECT 1 FROM dbt_workshop.competitors 
    WHERE name = 'Bright Future Academy'
    AND street_address = '753 Health Avenue'
);


