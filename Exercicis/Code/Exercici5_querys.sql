-- Consulta amigos y donde se conocieron --
-- PROBLEMA: que el usuario 1 y usuario 2 hacen referencia al mismo campo --

SELECT 
	username AS 'Usuario1',
	friend_user_id AS 'Usuario2',
	metway AS 'Se conocierón'
FROM users INNER JOIN howyoumet ON howyoumet.users_user_id = users.user_id;

-- Solución 1 --
SELECT 
	username AS 'Usuario1',
	(SELECT username FROM users WHERE friend_user_id=user_id ) AS 'Usuario2',
	metway AS 'Se conocierón'
FROM users INNER JOIN howyoumet ON howyoumet.users_user_id = users.user_id;

-- Solución 2 --
SELECT 
    (SELECT username FROM users WHERE users_user_id=user_id)  AS 'Usuario1',
    (SELECT username FROM users WHERE friend_user_id=user_id ) AS 'Usuario2',
    metway  AS 'se conocierón'
FROM howyoumet;

-- Cuantos amigos tiene el usuario 2. (tanto si aparece como usuario que declaro l'amistad o como amigoo) --
-- Solución 1: Introducir un WHERE y la lista es correcta pero desordenada--

SELECT 
    (SELECT username FROM users WHERE users_user_id=user_id) AS 'Usuario',
    (SELECT username FROM users WHERE friend_user_id=user_id ) AS 'Amigo'
FROM howyoumet 
WHERE users_user_id=2 OR friend_user_id=2;

-- Solución 2: Todo listado y desordenado--
SELECT 
    (SELECT username FROM users WHERE 
		CASE
			WHEN users_user_id=2 THEN users_user_id=user_id
			WHEN friend_user_id=2 THEN friend_user_id=user_id
		END
	) AS 'Usuario',
    (SELECT username FROM users WHERE 
    	CASE
			WHEN users_user_id=2 THEN friend_user_id=user_id
			WHEN friend_user_id=2 THEN users_user_id=user_id
		END 
	) AS 'Amigo'
FROM howyoumet 
WHERE users_user_id=2 OR friend_user_id=2;
