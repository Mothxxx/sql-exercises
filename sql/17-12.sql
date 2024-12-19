/*markdown
# Esercizio parziale 2022
*/

/*markdown
Esercizio 1    
CONDOMINIO (Codice, Via, Ncivico, Comune, NumPiani, Amministratore)   
APPARTAMENTO (<u>Condominio, NroProg</u>, Piano, Nvani, MQ)   
PERSONA (CF, Cognome, Nome, ComuneResidenza)   
PROPRIETÀ (CF, Condominio, NroApp, Percentuale, DataInizio)   
COMUNE (Nome, Via, NAbitanti)  
*/

/*markdown
dove 
•	Comune di CONDOMINIO e ComuneResidenza di PERSONA riferiscono entrambi Nome di COMUNE   
•	Condominio di APPARTAMENTO riferisce Codice di CONDOMINIO  
•	CF di PROPRIETÀ e Amministratore di CONDOMINIO riferiscono entrambi CF di PERSONA  
•	(Condominio, NroApp) di PROPRIETÀ riferisce (Condominio, NroProg) di APPARTAMENTO.  

*/

create schema query_sql;

use query_sql

CREATE TABLE COMUNE (
    Nome VARCHAR(100),
    Via VARCHAR(100),
    NAbitanti INT,
    PRIMARY KEY (Nome)
);

CREATE TABLE PERSONA (
    CF VARCHAR(16) PRIMARY KEY,
    Cognome VARCHAR(50),
    Nome VARCHAR(50),
    ComuneResidenza VARCHAR(100),
    FOREIGN KEY (ComuneResidenza) REFERENCES COMUNE(Nome)
);

CREATE TABLE CONDOMINIO (
    Codice CHAR(10),
    Via VARCHAR(100),
    Ncivico INT,
    Comune VARCHAR(100),
    NumPiani INT,
    Amministratore CHAR(16),
    PRIMARY KEY (Codice),
    FOREIGN KEY (Comune) REFERENCES COMUNE(Nome),
    FOREIGN KEY (Amministratore) REFERENCES PERSONA(CF)
);

CREATE TABLE APPARTAMENTO (
    Condominio VARCHAR(10),
    NroProg INT,
    Piano INT,
    Nvani INT,
    MQ INT,
    PRIMARY KEY (Condominio, NroProg),
    FOREIGN KEY (Condominio) REFERENCES CONDOMINIO(Codice)
);


SELECT* from appartamento;

CREATE TABLE PROPRIETA (
    CF VARCHAR(16),
    Condominio VARCHAR(10),
    NroApp INT,
    Percentuale DECIMAL(5, 2),
    DataInizio DATE,
    PRIMARY KEY (CF, Condominio, NroApp),
    FOREIGN KEY (CF) REFERENCES PERSONA(CF),
    FOREIGN KEY (Condominio,NroApp) REFERENCES APPARTAMENTO(Condominio, NroProg)
);

INSERT INTO COMUNE (Nome, Via, NAbitanti) VALUES
('Roma', 'Via del Corso', 2800000),
('Milano', 'Corso Buenos Aires', 1300000),
('Napoli', 'Via Toledo', 1000000),
('Torino', 'Corso Francia', 900000),
('Bologna', 'Via Indipendenza', 390000);

INSERT INTO PERSONA (CF, Cognome, Nome, ComuneResidenza) VALUES
('RSSMRA85M01H501Z', 'Rossi', 'Mario', 'Roma'),
('BNCLCU80A01F205X', 'Bianchi', 'Luigi', 'Milano'),
('VERLRI90R01H501A', 'Verdi', 'Giuseppe', 'Napoli'),
('ZANLND70B01L219C', 'Zani', 'Andrea', 'Torino'),
('GALLGI88P01L219D', 'Gallo', 'Francesca', 'Bologna');

INSERT INTO CONDOMINIO (Codice, Via, Ncivico, Comune, NumPiani, Amministratore) VALUES
('C001', 'Via Roma', 12, 'Roma', 5, 'RSSMRA85M01H501Z'),
('C002', 'Corso Buenos Aires', 15, 'Milano', 6, 'BNCLCU80A01F205X'),
('C003', 'Via Toledo', 20, 'Napoli', 4, 'VERLRI90R01H501A'),
('C004', 'Corso Francia', 45, 'Torino', 7, 'ZANLND70B01L219C'),
('C005', 'Via Indipendenza', 9, 'Bologna', 3, 'GALLGI88P01L219D');

INSERT INTO APPARTAMENTO (Condominio, NroProg, Piano, Nvani, MQ) VALUES
('C001', 1, 1, 4, 80),
('C001', 2, 2, 3, 75),
('C002', 1, 3, 5, 120),
('C003', 1, 1, 2, 55),
('C004', 1, 5, 3, 95);

INSERT INTO PROPRIETA (CF, Condominio, NroApp, Percentuale, DataInizio) VALUES
('RSSMRA85M01H501Z', 'C001', 1, 50.00, '2020-01-01'),
('BNCLCU80A01F205X', 'C001', 2, 100.00, '2019-06-15'),
('VERLRI90R01H501A', 'C002', 1, 75.00, '2021-03-10'),
('ZANLND70B01L219C', 'C003', 1, 60.00, '2020-11-22'),
('GALLGI88P01L219D', 'C004', 1, 100.00, '2022-02-28');

select * from proprieta

select * from condominio

select * from appartamento

select * from comune

select * from persona

/*markdown
Scrivere le interrogazioni SQL che permettono di determinare  
*/

SELECT DISTINCT p.CF, p.nome, p.cognome
FROM  persona p, condominio c, proprieta pr
WHERE p.CF = pr.CF 
  AND pr.condominio = c.codice 
  AND p.comuneResidenza='Roma' 
  AND c.comune='Milano';

/*markdown
2.	Gli appartamenti del condominio ‘C01’ che hanno un unico proprietario, con indicazione di tutte le informazioni sul loro proprietario.  
*/

SELECT pr.condominio, pr.nroApp, p.CF, p.nome, p.cognome
FROM proprieta pr, persona p
WHERE pr.CF = p.CF 
  AND pr.condominio = 'C001'
GROUP BY pr.condominio, pr.nroApp
HAVING COUNT(pr.CF) = 1;

DELETE FROM PROPRIETa
WHERE CF = 'BNCLCU80A01F205X' AND Condominio = 'C001' AND NroApp = 1
   OR CF = 'RSSMRA85M01H501Z' AND Condominio = 'C001' AND NroApp = 2;

/*markdown

3.	I condomini in cui ci sono almeno 10 appartamenti ed almeno 20 proprietari distinti.   

*/

SELECT pr.condominio, pr.nroApp
FROM proprieta pr
GROUP BY pr.condominio
HAVING COUNT(pr.nroApp) >= 10 AND COUNT(DISTINCT pr.CF) >= 20

/*markdown
4.	Per ogni città, i condomini con almeno 10 piani situati in tale città, mantenendo nel risultato anche le città per cui non presenti condomini con almeno 10 piani  
*/

SELECT c.comune, c.codice, c.numPiani
FROM comune co
LEFT JOIN condominio c ON co.nome = c.comune AND c.NumPiani >= 5;

5.	(OPZIONALE) Trovare le persone che sono amministratore di almeno un condominio in tutti i comuni   
*/

SELECT p.CF, p.Cognome, p.Nome
FROM PERSONA p,CONDOMINIO c, COMUNE com
WHERE p.CF = c.Amministratore
  AND c.Comune = com.Nome
  AND COMUNE com2 ON 1=1  -- Join per ottenere il numero totale di comuni
GROUP BY p.CF, p.Cognome, p.Nome
HAVING COUNT(DISTINCT com.Nome) = COUNT(DISTINCT com2.Nome); 

/*markdown

# Esercizio

*/

/*markdown
Si consideri lo schema dato per l’esercizio 1 e riportato di seguito:
*/

Gara (Codice, Nome, Regione, Disciplina)   
Edizione (Gara, Categoria, Data)  
Cavaliere (IdC, Nome, Cognome, Sesso, Città, DataN)  
Appartiene (Cavaliere, Categoria)  
Partecipa (Gara, Cavaliere, Categoria, OrdineArrivo)  

/*markdown
Scrivere le interrogazioni SQL che permettono di determinare :  
*/

/*markdown
1. Le gare a cui ha partecipato il maggior numero di  cavalieri, con l’indicazione della regione e della disciplina  delle gare stesse.
*/

CREATE VIEW NUMC(G,N) AS 
SELECT GARA, COUNT(*) AS N
FROM PARTECIPA 
GROUP BY GARA;

SELECT GARA, REGIONE, DISCIPLINA
FROM GARA, NUMC
WHERE G = CODICE AND N>=(SELECT MAX(N) 
                         FROM NUMC);

/*markdown
2. I cavalieri che hanno partecipato ad almeno 10 gare della regione Toscana e che appartengono ad almeno 3 categorie diverse.
*/

SELECT CVALIERE
FROM PARTECIPA, GARA
WHERE gara = codice AND regione = 'Toscana'
GROUP BY  CAVALIERE
HAVING COUNT(*)>=10
INTERSECT
SELECT CVALIERE
FROM APPARTIENE
GROUP BY CAVALIERE
HAVING COUNT(*) >= 3

/*markdown
3. Per ogni edizione di una gara della regione Toscana il numero dei cavalieri di Pescara che hanno partecipato a  
tale edizione. Se per una specifica edizione di una gara della regione Toscana non c’è nessun cavaliere di Pescara, non si vuole comunque perdere l’informazione sull’edizione.
*/

CREATE VIEW TP(G,C)
AS SELECT gara, cavaliere
FROM PARTECIPA, CVALIERE 
WHERE cavaliere =  Idc AND citta = 'Pescara';
-- ho creato una tabell con colonne solo gara cavaliere che contengono le tuple di cavaliere che sono di pescara

-- ora confronto TP con la tabella garaper vedere quali gare sono state svolte in toscana 
--e prendo il numero di cavalieri interessati
SELECT codice, COUNT(C)
FROM GARA LEFT JOIN TP
    ON codice = G
WHERE regione = 'Toscana'
GROUP BY codice

/*markdown
4. I cavalieri che hanno partecipato a tutte le gare della regione “Toscana”.
*/

CREATE VIEW NUMT(C,N)
AS SELECT cavaliere, COUNT(*)
FROM PARTECIPA, GARA
WHERE gara=codice and regione = 'Toscana'; 

-- Seleziona i cavalieri dalla vista NUMT il cui numero di partecipazioni (N) 
-- è uguale al numero totale di gare in Toscana.
SELECT C
FROM NUMT
WHERE N = (
            -- Conta il numero totale di gare che si svolgono nella regione 'Toscana'. 
            SELECT COUNT(*)
            FROM GARA
            WHERE regione = 'Toscana')

/*markdown
5. (opzionale) Le gare a cui hanno partecipato cavalieri tutti della stessa città
*/

SELECT gara 
FROM PARTCIPA, CAVALIERE
WHERE cavaiere = idc
GROUP BY gara
HAVING COUNT(DISTINCT città) = 1

/*markdown
# Appello 30-01-24
*/

/*markdown
Si consideri il seguente schema di base di dati per la gestione di una catena di supermercati:
*/

/*markdown
### Tabelle e Relazioni
*/

- **Prodotto(`CodP`, Nome, Tipologia)**
- **Fornitore(`CodF`, Nome, Città)**
- **Fornitura(`Fornitore, Prodotto`, PrezzoUnitario)**  
- **Spedizione(`CodS`, Data, CittàPart, CittàArr)**  
- **DettaglioSped(`Spedizione, Fornitore, Prodotto`, Quantità)**  

/*markdown
---
*/

/*markdown
### Requisiti delle interrogazioni
*/

/*markdown
Assumendo che la base di dati non contenga attributi con valori nulli (tranne dove indicato), scrivere le interrogazioni SQL per determinare quanto segue:
*/

/*markdown
1. **Per ogni fornitore di Pescara, la quantità totale di suoi prodotti nelle spedizioni che partono da Roma.**

*/

SELECT fornitore, SUM(quantità)
FROM FORNITORE, DETTAGLIOSPED D,SPEDIZIONE S,
WHERE codF = d.fornitore AND città = 'Pescara'
        AND s.codS = d.spedizione AND città = 'Roma'
GROUP BY fornitore  --quando ci sta 'per ogni' di solito

/*markdown
2. **Tutte le informazioni sulle spedizioni in cui non compaiono (nel dettaglio della spedizione) fornitori di Roma.**
*/

SELECT *
FROM SPEDIZIONE
WHERE  cosS NOT IN (SELECT spedizione 
                    FROM DETTAGLIOSPED, FORNITORE
                    WHERE fornitore=codF AND città='Roma')

/*markdown
3. **Le spedizioni per cui ci sono almeno 2 prodotti diversi di uno stesso fornitore.**
*/
*/

SELECT spedizione
FROM DETTAGLIOSPED
GROUP BY spedizione, fornitore
HAVING COUNT(*) >= 2

/*markdown
4. **Per ogni spedizione, il prodotto che è presente nella spedizione stessa, in quantità massima.**
*/

SELECT spedizione, prodotto
FROM DETTAGLIOSPED D1
WHERE quantità = (SELECT MAX(d2.quantità)
                    FROM DETTAGLISPED d2
                    WHERE d1.spedizione = d2.spedizione)

/*markdown
CORSO (CodCorso, NomeC, Anno, Semestre)  
ORARIO-LEZIONI (CodCorso, GiornoSettimana, OraInizio, OraFine, Aula)
*/

/*markdown
1. Trovare le aule in cui non si tengono mai lezioni di corsi del primo anno.
*/

SELECT DISTINCT aula 
FROM ORARIO_LEZIONI 
WHERE aula NOT IN ( SELECT aula 
                    FROM ORARIO_LEZIONI ol, corso c,
                    WHERE ol.codCorso=c.codCorso
                    AND c.anno = 1)

/*markdown
un'altra versione
*/

SELECT DISTINCT auala 
FROM ORARIO_LEZIONI ol1
WHERE NOT EXISTS (  SELECT * 
                    FROM ORARIO_LEZIONI ol2, CORSO c
                    WHERE ol2.codCorso = c.codCorso
                    AND c.anno = 1
                    AND ol2.aula = ol1.auala)

/*markdown
2. Trovare codice corso, nome corso e numero totale di ore di lezione settimanali per i corsi del terzo anno per cui il numero complessivo di ore di lezione settimanali é superiore a 10 e le lezioni sono in più di tre giorni diversi della settimana.
*/

SELECT c.codCorso, nomeC, SUM(oraFine - OraInizio)
FROM  CORSO c, ORARIO_LEZIONI ol
AND c.anno = 3
GROUP BY c.codCorso, c.nomeC
HAVING SUM(oraFine-oraInizio)> 10
AND COUNT(DISTINCT giornoSettimana) > 3;

/*markdown
------------------
*/

/*markdown
ALLOGGIO (CodA, Indirizzo, Città, Superficie, CostoAffittoMensile)  
CONTRATTO-AFFITTO (CodC, DataInizio, DataFine, NomePersona, CodA)
*/

/*markdown
3. N.B. Superficie espressa in metri quadri. Per i contratti in corso, DataFine é NULL.  
Trovare, per le città in cui sono stati stipulati almeno 100 contratti, la città, il costo mensile massimo degli affitti, il costo mensile medio degli affitti, la durata massima dei contratti, la durata media dei contratti e il numero totale di contratti stipulati
*/

SELECT città, MAX(costoAffittoMensile), AVG(costoAffittoMensile), 
       AVG(dataFine - dataInzio), MAX(dataFine - dataInzio), COUNT(*)
FROM ALLOGGGIO a, CONTRATTO_AFFITTO c,
WHERE a.codA = c.codA
GROUP BY città
HAVING COUNT(+)>=100;

/*markdown
------------------
*/

/*markdown
4. N.B. Superficie espressa in metri quadri. Per i contratti in corso, DataFine é NULL.  
Trovare il nome delle persone che non hanno mai affittato alloggi con superficie superiore a 80
metri quadri.
*/

SELECT DISTINCT nomePersona 
FROM CONTRATTO_AFFITTO
WHERE nomePersona NOT IN (
                          SELECT nomPersona
                          FROM CONTRATTO_AFFITTO c, ALLOGGIO a
                          WHERE c.codA = a.codA
                          AND superficie>80
                          ); 

/*markdown
------------------
*/

/*markdown
AEREI (Matr, Modello, NumPosti)  
ORARIO (Sigla, ParteDa, Destinaz, OraPart, OraArr)   
VOLI(sigla, matr, data, postiPren)  
*/

/*markdown
5. Trovare la sigla e l'ora di partenza dei voli in partenza da Milano per Napoli il 1 ottobre 1993, che
dispongono ancora di posti liberi la cui durata (di partenza tra l'ora di arrivo e l'ora di partenza) sia
inferiore alla durata media dei voli da Milano a Napoli.
*/

SELECT sigla, oraPart
FROM VOLI v, ORARIO o
WHERE v.sigla = o.sigla
    AND o.parteDa = 'Milano'
    AND o.Destinaz= 'Napoli'
    AND v.data = '1/10/1993'
    AND a.numPosti > v.postiPren
    AND (o.oraArr -o.oraPart) < SELECT AVG(oraArr - oraPart)
                                FROM VOLI v2, ORARIO o2
                                WHERE v2.sigla = o2.sigla
                                    AND o2.parteDa='Milano'
                                    AND o2.Destinaz='Napoli'

/*markdown
------------------
*/

/*markdown
ORCHESTRA(CodO, NomeO, NomrDirettore, numElementi)  
CONCERTI(CodC, Data, CodO, CodS, PrezzoBiglietto)  
SALE(CodS, NomeS, Città, Capienza) 
*/

/*markdown
6. Trovare il codice e il nome delle orchestre con più di 30 elementi che hanno tenuto concerti sia a
Torino, sia a Milano e non hanno mai tenuto concerti a Bologna.
*/

SELECT c.agenzia
FROM CONTO c, CONTO_CLIENTE cl
WHERE c.cod_conto = cl.cod_conto
    AND NOT EXISTS 
        (SELECT * FROM CONTO_CLIENTE cl2
         WHERE cl2.cod_conto = cl.cod_conto
            AND cl2.cod_Cli <> cl.cod_cli)
    AND NOT EXISTS
        (SELECT * FROM CONTO_CLIENTE cl3
         WHERE cl3.cod_cli = cl.cod_cli
            AND cl3.cod_conto <> cl.cod_conto)

/*markdown
CONTRIBUENTE(CodFiscale, Nome, Via, Citt_ a)   
DICHIARAZIONE(CodDichiarazione, Tipo, Reddito)  
PRESENTA(CodFiscale, CodDichiarazione, Data)
*/

/*markdown

8. Visualizzare codice, nome e media dei redditi dichiarati dal 1990 in poi per i contribuenti tali che il
massimo reddito da loro dichiarato dal 1990 in poi sia superiore alla media dei redditi calcolata su
tutte le dichiarazioni nel database.


*/

/*markdown
PERSONA(Nome, Sesso, Età)   
GENITORE(Nome-Gen, Nome-Figlio)
*/

/*markdown

9. Trovare il nome di tutte le persone con età a inferiore a 10 anni che sono figli unici.



*/