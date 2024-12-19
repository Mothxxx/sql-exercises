Torna all' Outer Join [[OUTER JOIN]]
**FULL JOIN**
Un **FULL JOIN** combina i risultati di un **LEFT JOIN** e un **RIGHT JOIN**.
- **Include tutti i record di entrambe le tabelle**, anche quelli che non trovano corrispondenza.
- Quando non c’è corrispondenza, i campi corrispondenti saranno **NULL**.

**Tabelle di esempio**
1. **Clienti:**
```markdown
| cliente_id | nome  | città   |
|------------|-------|---------|
| 1          | Anna  | Milano  |
| 2          | Marco | Roma    |
| 3          | Lucia | Napoli  |
| 4          | Paolo | Torino  |
```

2. **Ordini**
```markdown
| ordine_id | cliente_id | importo |
|-----------|------------|---------|
| 101       | 1          | 100.50  |
| 102       | 2          | 200.00  |
| 103       | 5          | 50.00   |
```

**Risultato FULL JOIN**
Esempio di query:
```sql
SELECT nome, città, importo 
FROM Clienti 
FULL JOIN Ordini 
ON Clienti.cliente_id = Ordini.cliente_id;
```

**Tabella risultante:**
```markdown
| nome     | città   | importo |
|----------|---------|---------|
| Anna     | Milano  | 100.50  |
| Marco    | Roma    | 200.00  |
| Lucia    | Napoli  | NULL    |
| Paolo    | Torino  | NULL    |
| NULL     | NULL    | 50.00   |
```

**Osservazioni:**
1. **Anna e Marco**: Entrambi hanno ordini corrispondenti, quindi i loro record appaiono con tutti i campi popolati.
2. **Lucia e Paolo**: Appaiono perché fanno parte della tabella Clienti, ma non hanno ordini, quindi i loro valori di importo sono NULL.
3. **cliente_id 5 (Ordini)**: Non corrisponde a nessun cliente nella tabella Clienti, quindi i valori di nome e città sono NULL.