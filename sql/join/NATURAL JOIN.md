Torna alla pagina principale [[Base dati]]
Torna all'Inner Join [[INNER JOIN]]
**NATURAL JOIN – Definizione**
Il **NATURAL JOIN** è un tipo di **join** che combina due tabelle in base alle colonne che hanno lo stesso nome e tipo di dato in entrambe le tabelle. A differenza degli altri tipi di join, in cui devi specificare esplicitamente le colonne su cui effettuare la corrispondenza, il **NATURAL JOIN** si occupa automaticamente di individuare le colonne comuni e fare il join su di esse.

**Caratteristiche principali del NATURAL JOIN**
1. **Rilevamento automatico delle colonne**: Il join si basa sulle colonne che hanno lo stesso nome e tipo in entrambe le tabelle. Non è necessario specificare le colonne per il join.
2. **Eliminazione delle colonne duplicate**: Nei risultati, le colonne che vengono utilizzate per il join appaiono una sola volta. Questo significa che se entrambe le tabelle hanno una colonna con lo stesso nome, questa comparirà una sola volta nei risultati, evitando duplicati.

**Sintassi**
La sintassi di un **NATURAL JOIN** è semplice:
```sql
SELECT colonne
FROM tabella1
NATURAL JOIN tabella2;
```

**Esempio di uso**
Supponiamo di avere due tabelle:
**Tabella Dipendenti**

| id  | nome  | reparto_id |
| --- | ----- | ---------- |
| 1   | Mario | 101        |
| 2   | Luca  | 102        |

**Tabella Reparti**

| id  | nome_reparto  |
| --- | ------------- |
| 101 | Risorse Umane |
| 102 | IT            |
Vogliamo fare un join tra queste due tabelle basato sulla colonna id (che è presente in entrambe le tabelle con lo stesso nome):
```sql
SELECT *
FROM Dipendenti
NATURAL JOIN Reparti;
```

**Risultato del NATURAL JOIN:**
Poiché la colonna id è presente in entrambe le tabelle e verrà utilizzata automaticamente dal **NATURAL JOIN**, la tabella risultante sarà:

| id  | nome  | reparto_id | nome_reparto  |
|-----|-------|------------|---------------|
| 1   | Mario | 101        | Risorse Umane |
| 2   | Luca  | 102        | IT            |
Nel caso di un NATURAL JOIN, la colonna id è presente in entrambe le tabelle, ma apparirà una sola volta nel risultato, insieme alle altre colonne combinate.

**Vantaggi del NATURAL JOIN**
• **Semplicità**: Non è necessario specificare manualmente le colonne di join. SQL trova automaticamente quelle che hanno lo stesso nome.
• **Riduzione dei duplicati**: Se le tabelle hanno colonne con lo stesso nome, queste appariranno solo una volta nel risultato.

**Limitazioni del NATURAL JOIN**
1. **Ambiguità**: Se le tabelle contengono colonne con lo stesso nome che non dovrebbero essere utilizzate per il join (ad esempio colonne che rappresentano concetti diversi ma hanno lo stesso nome), il NATURAL JOIN potrebbe restituire risultati inaspettati.

2. **Controllo limitato**: Poiché non specifichi le colonne per il join, potrebbe non essere chiaro quali colonne vengano utilizzate. Questo può rendere difficile il controllo delle query in casi complessi.

3. **Flessibilità ridotta**: Se vuoi avere un controllo preciso sul tipo di join o sulle colonne coinvolte, è meglio utilizzare un altro tipo di join (come INNER JOIN o LEFT JOIN), specificando esplicitamente le colonne.

**Quando usarlo**
• **Quando le tabelle hanno colonne con lo stesso nome che dovrebbero essere unite insieme** e non vuoi specificare manualmente ogni colonna.

• **Per semplificare il codice** in situazioni in cui le colonne di join sono chiaramente comuni tra le tabelle.

**Esempio di più colonne comuni**
Se due tabelle hanno più colonne con lo stesso nome, il NATURAL JOIN le userà tutte per fare il join. Ad esempio: