/*Queries that provide answers to the questions from all projects.*/

SELECT * 
FROM animals 
WHERE name 
LIKE '%mon';

SELECT name 
FROM animals 
WHERE date_of_birth
BETWEEN '2016-01-01' AND '2019-12-31'

SELECT name 
FROM animals 
WHERE neutured = true AND escape_attempts < 3

SELECT date_of_birth
FROM animals 
WHERE name IN ('Agumon', 'Pikachu')

SELECT name, escape_attempts
FROM animals 
WHERE weight_kg > 10.5

SELECT *
FROM animals 
WHERE neutured = true

SELECT *
FROM animals 
WHERE name !== 'Gabumon'

SELECT *
FROM animals 
WHERE weight_kg BETWEEN 10.4 AND 17.3

-- Adding 'unspecified' to the species

BEGIN;

UPDATE animals;
SET species = 'unspecified';

SELECT species 
FROM animals;

ROLLBACK;

SELECT species 
FROM animals;

-- Adding Species to the species column

BEGIN;

UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;

COMMIT;

-- Deleting the entire table and rolling back

BEGIN;

DELETE FROM animals;

ROLLBACK;

-- Creating SAVEPOINTS

BEGIN;

DELETE FROM animals
WHERE date_of_birth > '2022-01-01';

SAVEPOINT my_savepoint;

UPDATE animals
SET weight_kg = weight_kg * -1;

ROLLBACK TO SAVEPOINT my_savepoint;

UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;

COMMIT; 

-- How many animals are there?

SELECT COUNT(*)
FROM animals

-- How many animals have never tried to escape?

SELECT COUNT(*)
FROM animals
WHERE escape_attempts = 0

-- What is the average weight of animals?

SELECT AVG(weight_kg) as average_weight
FROM animals

-- Who escapes the most, neutered or not neutered animals?

SELECT neutured, COUNT(*) AS escape_count
FROM animals
WHERE escape_attempts > 0
GROUP BY neutured
ORDER BY COUNT(*) DESC;

-- What is the minimum and maximum weight of each type of animal?

SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight
FROM animals
GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?

SELECT species, AVG(escape_attempts) as average_escape_attempt
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;
