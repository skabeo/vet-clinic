/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutured, weight_kg) VALUES ('Agumon', '2020-02-03', 0, true, 10.23);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutured, weight_kg) VALUES ('Gabumon', '2018-11-15', 2, true, 8);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutured, weight_kg) VALUES ('Pikachu', '2021-01-07', 1, false, 15.04);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutured, weight_kg) VALUES ('Devimon', '2017-05-12', 5, true, 11);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutured, weight_kg, species)
VALUES
    ('Charmander', '2020-02-08', 0, false, -11, ''),
    ('Planton', '2021-11-15', 2, true, -5.7, ''),
    ('Squirtle', '1993-04-02', 3, false, -12.13, ''),
    ('Angemon', '2005-06-12', 1, true, -45, ''),
    ('Boarmon', '2005-06-07', 7, true, 20.4, ''),
    ('Blossom', '1998-10-13', 3, true, 17, ''),
    ('Ditto', '2022-05-14', 4, true, 22, '');

UPDATE animals
SET name = 'Plantmon'
WHERE id = 6;

-- Inserting data into owners table

INSERT INTO owners (full_name, age) VALUES ('Sam Smith', 34);
INSERT INTO owners (full_name, age) VALUES ('Jennifer Orwell', 19);
INSERT INTO owners (full_name, age) VALUES ('Bob', 45);
INSERT INTO owners (full_name, age) VALUES ('Melody Pond', 77);
INSERT INTO owners (full_name, age) VALUES ('Dean Winchester', 14);
INSERT INTO owners (full_name, age) VALUES ('Jodie Whittaker', 38);

-- Inserting data into species table

INSERT INTO species (name) VALUES ('Pokemon');
INSERT INTO species (name) VALUES ('Digimon');

-- Updating species_id column in animals table

    -- If the name ends in "mon" it will be Digimon
    UPDATE animals
    SET species_id = (SELECT id FROM species WHERE name = 'Digimon')
    WHERE name LIKE '%mon';

    -- All other animals are Pokemon
    UPDATE animals
    SET species_id = (SELECT id FROM species WHERE name = 'Pokemon')
    WHERE name NOT LIKE '%mon';


-- Updating entries in the owners table

    -- Sam Smith owns Agumon
    UPDATE animals
    SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith')
    WHERE name = 'Agumon';

    -- Jennifer Orwell owns Gabumon and Pikachu.
    UPDATE animals
    SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
    WHERE name IN ('Gabumon', 'Pikachu');

    -- Bob owns Devimon and Plantmon.
    UPDATE animals
    SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob')
    WHERE name IN ('Devimon', 'Plantmon');

    -- Melody Pond owns Charmander, Squirtle, and Blossom.
    UPDATE animals
    SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond')
    WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

    -- Dean Winchester owns Angemon and Boarmon.
    UPDATE animals
    SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
    WHERE name IN ('Angemon', 'Boarmon');