# TALLER 03 - SQL

use sakila;

# Parte 1- SELECT y WHERE
# 1. Mostrar nombre y apellido de todos los clientes.

SELECT first_name, last_name FROM customer;

# 2. Películas con duración mayor a 120 minutos.

SELECT * FROM film
WHERE length >120;

# Parte 2- ORDER BY
# 3. Ordenar clientes por apellido A-Z

SELECT first_name, last_name
FROM customer
ORDER BY last_name ASC;

#4. Top 5 películas más largas --> TIP: Use la palabra LIMIT

SELECT title, length
FROM film  
ORDER BY length DESC
LIMIT 5;

# PARTE 3- INNER JOIM
# 5. Cantidad pagada y fecha de pago con nombre y apellido del cliente (JOIN entre Payment - Customer)

SELECT customer.first_name, customer.last_name, payment.amount, payment.payment_date FROM payment
JOIN customer ON payment.customer_id = customer.customer_id;

# 6. Películas alquiladas (JOIN entre Rental - Inventory - Film)




# PARTE 4- LEFT JOIN
# 7. Nombre y apellido de clientes sin pagos (LEFT JOIN entre Payment - Customer pero usando WHERE)

SELECT customer.first_name, customer.last_name FROM customer
LEFT JOIN payment ON customer.customer_id = payment.customer_id
WHERE payment.payment_id IS NULL;

# Listar los nombres de las peliculas y su duracion de aquellos titulos que no tienen actores

SELECT film.title, film.length FROM film
LEFT JOIN film_actor ON film.film_id = film_actor.film_id
WHERE film_actor.actor_id IS NULL;

# Parte 5- INSERT, UPDATE, DELETE (Data Definition Language 
# 9. Insertar actor temporal

INSERT INTO actor (first_name, last_name)
VALUES ('Tatiana', 'Gomez');

# 10. Actualizar actor

UPDATE actor 
SET first_name = 'TATIANA', last_name = 'GOMEZ'
WHERE actor_id = '204';

# 11. Eliminar actor

DELETE FROM actor
WHERE actor_id = '204';

# Parte 6- Consultas Avanzadas
#12. Top 5 clientes con mayor cantidad de dinero pagado al servicio de rentas

SELECT customer.customer_id, customer.first_name, customer.last_name,
    SUM(payment.amount) AS total_pagado FROM customer 
JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id, customer.first_name, customer.last_name
ORDER BY total_pagado DESC
LIMIT 5;

# 13. Top 5 Películas más alquiladas (JOIN entre Rental - Inventory - Film) --> Agrupar los datos con conteo y tomar las mejores 5

SELECT film.title, COUNT(rental.rental_id) AS total_alquileres FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
GROUP BY film.film_id, film.title
ORDER BY total_alquileres DESC
LIMIT 5;