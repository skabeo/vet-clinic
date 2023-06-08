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


-- Add values to vets table

INSERT INTO vets (name, age, date_of_graduation)
VALUES ('William Tatcher', 45, '2000-04-23');

INSERT INTO vets (name, age, date_of_graduation)
VALUES ('Maisy Smith', 26, '2019-01-17');

INSERT INTO vets (name, age, date_of_graduation)
VALUES ('Stephanie Mendez', 64, '1981-05-04');

INSERT INTO vets (name, age, date_of_graduation)
VALUES ('Jack Harkness', 38, '2008-06-08');

-- Add data to specialization table 

    -- William Tatcher is specialized in Pokemon.
    INSERT INTO specializations (vet_id, species_id)
    SELECT v.id, s.id
    FROM vets v
    JOIN species s on s.name = 'Pokemon'
    WHERE v.name = 'William Tatcher';

    -- Stephanie Mendez is specialized in Digimon and Pokemon.
    INSERT INTO specializations (vet_id, species_id)
    SELECT v.id, s.id
    FROM vets v 
    JOIN species s on s.name = 'Digimon'
    WHERE v.name = 'Stephanie Mendez';

    INSERT INTO specializations (vet_id, species_id)
    SELECT v.id, s.id
    FROM vets v 
    JOIN species s on s.name = 'Pokemon'
    WHERE v.name = 'Stephanie Mendez';

    -- Jack Harkness is specialized in Digimon.
    INSERT INTO specializations (vet_id, species_id)
    SELECT v.id, s.id
    FROM vets v 
    JOIN species s on s.name = 'Digimon'
    WHERE v.name = 'Jack Harkness';


-- Add data into visits table

    -- Agumon visited William Tatcher on May 24th, 2020.
    INSERT INTO visits (animal_id, vet_id, visit_date)
    SELECT a.id, v.id, '2020-05-24'
    FROM animals a
    JOIN vets v on v.name = 'William Tatcher'
    WHERE a.name = 'Agumon';

    -- Agumon visited Stephanie Mendez on Jul 22th, 2020.
    INSERT INTO visits (animal_id, vet_id, visit_date)
    SELECT a.id, v.id, '2020-07-22'
    FROM animals a
    JOIN vets v on v.name = 'Stephanie Mendez'
    WHERE a.name = 'Agumon';

    -- Gabumon visited Jack Harkness on Feb 2nd, 2021.
    INSERT INTO visits (animal_id, vet_id, visit_date)
    SELECT a.id, v.id, '2021-02-02'
    FROM animals a
    JOIN vets v on v.name = 'Jack Harkness'
    WHERE a.name = 'Gabumon';

    -- Pikachu visited Maisy Smith on Jan 5th, 2020.
    INSERT INTO visits (animal_id, vet_id, visit_date)
    SELECT a.id, v.id, '2020-01-05'
    FROM animals a
    JOIN vets v on v.name = 'Maisy Smith'
    WHERE a.name = 'Pikachu';

    -- Pikachu visited Maisy Smith on Mar 8th, 2020.
    INSERT INTO visits (animal_id, vet_id, visit_date)
    SELECT a.id, v.id, '2020-03-08'
    FROM animals a
    JOIN vets v on v.name = 'Maisy Smith'
    WHERE a.name = 'Pikachu';

    -- Pikachu visited Maisy Smith on May 14th, 2020.
    INSERT INTO visits (animal_id, vet_id, visit_date)
    SELECT a.id, v.id, '2020-05-14'
    FROM animals a
    JOIN vets v on v.name = 'Maisy Smith'
    WHERE a.name = 'Pikachu';

    -- Devimon visited Stephanie Mendez on May 4th, 2021.
    INSERT INTO visits (animal_id, vet_id, visit_date)
    SELECT a.id, v.id, '2021-05-04'
    FROM animals a
    JOIN vets v on v.name = 'Stephanie Mendez'
    WHERE a.name = 'Devimon';

    -- Charmander visited Jack Harkness on Feb 24th, 2021.
    INSERT INTO visits (animal_id, vet_id, visit_date)
    SELECT a.id, v.id, '2021-02-24'
    FROM animals a
    JOIN vets v on v.name = 'Jack Harkness'
    WHERE a.name = 'Charmander';

    -- Plantmon visited Maisy Smith on Dec 21st, 2019.
    INSERT INTO visits (animal_id, vet_id, visit_date)
    SELECT a.id, v.id, '2019-12-21'
    FROM animals a
    JOIN vets v on v.name = 'Maisy Smith'
    WHERE a.name = 'Plantmon';

    -- Plantmon visited William Tatcher on Aug 10th, 2020.
    INSERT INTO visits (animal_id, vet_id, visit_date)
    SELECT a.id, v.id, '2020-08-10'
    FROM animals a
    JOIN vets v on v.name = 'William Tatcher'
    WHERE a.name = 'Plantmon';

    -- Plantmon visited Maisy Smith on Apr 7th, 2021.
    INSERT INTO visits (animal_id, vet_id, visit_date)
    SELECT a.id, v.id, '2021-04-07'
    FROM animals a
    JOIN vets v on v.name = 'Maisy Smith'
    WHERE a.name = 'Plantmon';

    -- Squirtle visited Stephanie Mendez on Sep 29th, 2019.
    INSERT INTO visits (animal_id, vet_id, visit_date)
    SELECT a.id, v.id, '2019-09-29'
    FROM animals a
    JOIN vets v on v.name = 'Stephanie Mendez'
    WHERE a.name = 'Squirtle';

    -- Angemon visited Jack Harkness on Oct 3rd, 2020.
    INSERT INTO visits (animal_id, vet_id, visit_date)
    SELECT a.id, v.id, '2020-10-03'
    FROM animals a
    JOIN vets v on v.name = 'Jack Harkness'
    WHERE a.name = 'Angemon';

    -- Angemon visited Jack Harkness on Nov 4th, 2020.
    INSERT INTO visits (animal_id, vet_id, visit_date)
    SELECT a.id, v.id, '2020-11-04'
    FROM animals a
    JOIN vets v on v.name = 'Jack Harkness'
    WHERE a.name = 'Angemon';

    -- Boarmon visited Maisy Smith on Jan 24th, 2019.
    INSERT INTO visits (animal_id, vet_id, visit_date)
    SELECT a.id, v.id, '2019-01-24'
    FROM animals a
    JOIN vets v on v.name = 'Maisy Smith'
    WHERE a.name = 'Boarmon';

    -- Boarmon visited Maisy Smith on May 15th, 2019.
    INSERT INTO visits (animal_id, vet_id, visit_date)
    SELECT a.id, v.id, '2019-05-15'
    FROM animals a
    JOIN vets v on v.name = 'Maisy Smith'
    WHERE a.name = 'Boarmon';

    -- Boarmon visited Maisy Smith on Feb 27th, 2020.
    INSERT INTO visits (animal_id, vet_id, visit_date)
    SELECT a.id, v.id, '2020-02-27'
    FROM animals a
    JOIN vets v on v.name = 'Maisy Smith'
    WHERE a.name = 'Boarmon';

    -- Boarmon visited Maisy Smith on Aug 3rd, 2020.
    INSERT INTO visits (animal_id, vet_id, visit_date)
    SELECT a.id, v.id, '2020-08-03'
    FROM animals a
    JOIN vets v on v.name = 'Maisy Smith'
    WHERE a.name = 'Boarmon';

    -- Blossom visited Stephanie Mendez on May 24th, 2020.
    INSERT INTO visits (animal_id, vet_id, visit_date)
    SELECT a.id, v.id, '2020-05-24'
    FROM animals a
    JOIN vets v on v.name = 'Stephanie Mendez'
    WHERE a.name = 'Blossom';

    -- Blossom visited William Tatcher on Jan 11th, 2021.
    INSERT INTO visits (animal_id, vet_id, visit_date)
    SELECT a.id, v.id, '2021-01-11'
    FROM animals a
    JOIN vets v on v.name = 'William Tatcher'
    WHERE a.name = 'Blossom';
