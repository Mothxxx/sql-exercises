Torna alla pagina principale [[Base dati]]
Torna all' Outer Join [[OUTER JOIN]]
**RIGHT JOIN**
**Definizione:**
Una **RIGHT JOIN** (o **RIGHT OUTER JOIN**) restituisce **tutti i record dalla tabella di destra** (la seconda tabella indicata nella query) **e i record corrispondenti dalla tabella di sinistra**. Se non ci sono corrispondenze, i campi della tabella di sinistra vengono riempiti con valori NULL.

**Sintassi:**
```sql
SELECT colonne
FROM tabella1
RIGHT JOIN tabella2
ON tabella1.colonna_comune = tabella2.colonna_comune;
```

**Esempio pratico:**
**Tabelle:**
**Clienti:**
```markdown
| cliente_id | nome  | città   |
|------------|-------|---------|
| 1          | Anna  | Milano  |
| 2          | Marco | Roma    |
| 3          | Lucia | Napoli  |
```

**Ordini:**
```markdown
| ordine_id | cliente_id | importo |
|-----------|------------|---------|
| 101       | 1          | 100.50  |
| 102       | 2          | 200.00  |
```

**Query:**
```sql
SELECT clienti.nome, ordini.importo
FROM clienti
RIGHT JOIN ordini
ON clienti.cliente_id = ordini.cliente_id;
```

**Risultato:**
```markdown
| nome     | importo  |
|----------|----------|
| Anna     | 100.50   |
| Marco    | 200.00   |
```