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


-- What animals belong to Melody Pond?

SELECT a.name as animals_name
FROM animals a
JOIN owners o on a.owner_id = o.id
WHERE o.full_name = 'Melody Pond';

-- List of all animals that are pokemon.

SELECT a.name
FROM animals a 
JOIN species s on a.species_id = s.id
WHERE s.name = 'Pokemon';

-- List all owners and their animals.

SELECT o.full_name, a.name
FROM animals a
RIGHT JOIN owners o on a.owner_id = o.id;

-- How many animals are there per species?

SELECT s.name as species_name, COUNT(a.name) as animals_count
FROM animals a
JOIN species s on a.species_id = s.id
GROUP BY s.name;

-- List all Digimon owned by Jennifer Orwell.

SELECT a.name as digimon_name
FROM animals a 
JOIN owners o on a.owner_id = o.id
JOIN species s on a.species_id = s.id
WHERE o.full_name = 'Jennifer Orwell' AND s.name = 'Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape

SELECT a.name
FROM animals a
JOIN owners o on a.owner_id = o.id
WHERE o.full_name = 'Dean Winchester' and a.escape_attempts = 0;

-- Who owns the most animals?

SELECT o.full_name as owners, COUNT(*) as animals_count
FROM animals a 
JOIN owners o on a.owner_id = o.id
GROUP BY o.full_name
ORDER BY animals_count DESC;


-- Who was the last animal seen by William Tatcher?

SELECT a.name
FROM animals a
JOIN visits v ON a.id = v.animal_id
JOIN vets vt ON vt.id = v.vet_id
WHERE vt.name = 'William Tatcher'
ORDER BY v.visit_date DESC
LIMIT 1;

-- How many different animals did Stephanie Mendez see?

SELECT s.name, COUNT(*) as animals
FROM animals a
JOIN species s on a.species_id = s.id
JOIN visits v on a.id = v.animal_id
JOIN vets vt on v.vet_id = vt.id
WHERE vt.name = 'Stephanie Mendez'
GROUP BY s.name

-- List all vets and their specialties, including vets with no specialties.

SELECT vt.name, sp.name
FROM vets vt
LEFT JOIN specializations s on vt.id = s.vet_id
LEFT JOIN species sp on s.species_id = sp.id

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.

SELECT a.name
FROM animals a
JOIN visits v on a.id = v.animal_id
JOIN vets vt on v.vet_id = vt.id
WHERE v.visit_date BETWEEN '2020-04-01' and '2020-08-30'
AND vt.name = 'Stephanie Mendez'

-- What animal has the most visits to vets?

SELECT a.name, vt.name, COUNT(*) as animal_count
FROM animals a
JOIN visits v on a.id = v.animal_id
JOIN vets vt on v.vet_id = vt.id
GROUP BY a.name, vt.name
ORDER BY animal_count DESC
LIMIT 1

-- Who was Maisy Smith's first visit?

SELECT a.name
FROM animals a
JOIN visits v on a.id = v.animal_id
JOIN vets vt on v.vet_id = vt.id
WHERE vt.name = 'Maisy Smith'
ORDER BY v.visit_date
LIMIT 1

-- Details for most recent visit: animal information, vet information, and date of visit.

SELECT a.name, o.full_name, vt.name, v.visit_date
FROM animals a
JOIN owners o on a.owner_id = o.id
JOIN visits v on a.id = v.animal_id
JOIN vets vt on v.vet_id = vt.id
ORDER BY v.visit_date DESC
LIMIT 1

-- How many visits were with a vet that did not specialize in that animal's species?

SELECT COUNT(*) AS mismatched_visits_count
FROM visits v
JOIN animals a ON a.id = v.animal_id
JOIN vets vt ON vt.id = v.vet_id
LEFT JOIN specializations sp ON vt.id = sp.vet_id AND a.species_id = sp.species_id
WHERE sp.species_id IS NULL;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.

SELECT s.name, COUNT(*) as species_count
FROM visits v
JOIN vets vt on v.vet_id = vt.id
JOIN animals a on a.id = v.animal_id
JOIN species s on a.species_id = s.id
WHERE vt.name = 'Maisy Smith'
GROUP BY s.name
ORDER BY COUNT(*) DESC
