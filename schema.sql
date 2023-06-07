/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name varchar(100),
    date_of_birth DATE,
    escape_attempts INT,
    neutured BOOLEAN,
    weight_kg DECIMAL(5, 2)
);

ALTER TABLE animals
ADD COLUMN species varchar(100);

-- Create owners table

CREATE TABLE owners (
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name varchar(100),
    age INT,
    PRIMARY KEY(id)
);

-- Create species table

CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY,
    name varchar(100),
    PRIMARY KEY(id)
);

-- Animal table modifications

  -- deleting species column
    ALTER TABLE animals
    DROP COLUMN species;

  -- adding species_id column
    ALTER TABLE animals
    ADD COLUMN species_id INT REFERENCES species(id);

  -- adding owner_id column
    ALTER TABLE animals
    ADD COLUMN owner_id INT REFERENCES owners(id);

