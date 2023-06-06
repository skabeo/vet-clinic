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
