CREATE FUNCTION calculer_longueur_max(IN string1 char,IN string2 char)
RETURNS integer AS $calculer_longueur_max$
    DECLARE
        long1 integer;
        long2 integer;
        longueur_max integer;
    BEGIN
        long1 := char_length(string1);
        long2 := char_length(string2);
        If long1 > long2 THEN
            longueur_max := long1;
        Else
            longueur_max := long2;
        End IF;
        Raise Info 'la chaine de caractere la plus longue est de : % caracteres', longueur_max ;
        return longueur_max;
    END;
$calculer_longueur_max$ LANGUAGE plpgsql;




CREATE OR REPLACE FUNCTION getNbJoursParMois(date_param date)
RETURNS integer AS $$
DECLARE
    nb_jours integer;
BEGIN
    IF (EXTRACT(MONTH FROM date_param) = 2) THEN
        IF (EXTRACT(YEAR FROM date_param) % 4 = 0 AND (EXTRACT(YEAR FROM date_param) % 100 != 0 OR EXTRACT(YEAR FROM date_param) % 400 = 0)) THEN
            nb_jours := 29;
        ELSE
            nb_jours := 28;
        END IF;
    ELSE
        nb_jours := EXTRACT(DAY FROM (DATE_TRUNC('month', date_param) + INTERVAL '1 month - 1 day'));
    END IF;

    RETURN nb_jours;
END;
$$ LANGUAGE plpgsql;


SELECT getNbJoursParMois('2022-02-01'); -- renvoie 28




CREATE OR REPLACE FUNCTION nb_occurrences(caractere CHAR, chaine TEXT, debut INTEGER, fin INTEGER)
RETURNS INTEGER AS $$
DECLARE
    sous_chaine TEXT;
    nb_occurrences INTEGER := 0;
BEGIN
    sous_chaine := substr(chaine, debut, fin - debut + 1);
        nb_occurrences := length(sous_chaine) - length(replace(sous_chaine, caractere, ''));
        RETURN nb_occurrences;
END;
$$ LANGUAGE plpgsql;




/* For */
CREATE OR REPLACE FUNCTION nb_occurrences(caractere CHAR, chaine TEXT, debut INTEGER, fin INTEGER)
RETURNS INTEGER AS $$
DECLARE
    nb_occurrences INTEGER := 0;
    chaine_array CHAR[];
    i INTEGER;
BEGIN
    chaine_array := string_to_array(chaine, NULL);
    IF debut < fin
    AND fin < length(chaine)
    THEN    
        FOR i IN debut..fin LOOP
        
            IF chaine_array[i] = caractere THEN
                nb_occurrences := nb_occurrences + 1;
            END IF;
        END LOOP;
    ELSE 
        RAISE INFO 'Intervalle Incorrecte' ;
        return 0 ;
    END IF;    
    RETURN nb_occurrences;
END;
$$ LANGUAGE plpgsql;
/* Fin For Fin */




/* Loop */
CREATE OR REPLACE FUNCTION nb_occurrences(caractere CHAR, chaine TEXT, debut INTEGER, fin INTEGER)
RETURNS INTEGER AS $$
DECLARE
    nb_occurrences INTEGER := 0;
    i INTEGER := debut;
BEGIN
    IF debut < fin 
    AND fin < length(chaine)
    THEN      
        LOOP
            IF i > fin THEN
                EXIT;
            END IF;
            IF substring(chaine from i for 1) = caractere THEN
                nb_occurrences := nb_occurrences + 1;
            END IF;
            i := i + 1;
        END LOOP;
    ELSE 
        RAISE INFO 'Intervalle Incorrecte' ;
        return 0 ;
    END IF; 
    RETURN nb_occurrences;
END;
$$ LANGUAGE plpgsql;
/* Fin Loop Fin */





/* While */
CREATE OR REPLACE FUNCTION nb_occurrences(caractere CHAR, chaine TEXT, debut INTEGER, fin INTEGER)
RETURNS INTEGER AS $$
DECLARE
    nb_occurrences INTEGER := 0;
    i INTEGER := debut;
    car CHAR;
BEGIN
    IF debut < fin 
    AND fin < length(chaine)
    THEN
        WHILE i <= fin LOOP
            car := substring(chaine from i for 1);
            IF car = caractere THEN
                nb_occurrences := nb_occurrences + 1;
            END IF;
            i := i + 1;
        END LOOP;
    ELSE 
        RAISE INFO 'Intervalle Incorrecte' ;
        return 0 ;
    END IF; 
    RETURN nb_occurrences;
END;
$$ LANGUAGE plpgsql;
/* Fin While Fin */

SELECT nb_occurrences('a', 'abracadabra', 1, 8); -- renvoie 4
SELECT nb_occurrences('b', 'abracadabra', 0, 5); -- renvoie 1
SELECT nb_occurrences('z', 'abracadabra', 0, 5); -- renvoie 0

/* Fin Nombre d'occurrences Fin */

/* Nombre de Jours */

