Torna alla pagina principale [[Base dati]]
Torna all'Inner Join [[INNER JOIN]]
Il **theta join** è un tipo di **join** utilizzato nei database relazionali per combinare due tabelle in base a una condizione di confronto che non deve necessariamente essere un’uguaglianza (come avviene per l’**equijoin**). In altre parole, un **theta join** permette di unire due tabelle utilizzando operatori di confronto che possono includere:
• **Uguale (**=**)**
• **Maggiore di (**>**)**
• **Minore di (**<**)**
• **Maggiore o uguale (**>=**)**
• **Minore o uguale (**<=**)**
• **Diverso da (**!= **o** <>**)**

**Sintassi del Theta Join**
La sintassi di un **theta join** in SQL è simile a quella di un join qualsiasi, ma con una condizione personalizzata di confronto che può essere diversa dall’uguaglianza. La condizione di join può essere un’espressione booleana che utilizza uno dei suddetti operatori di confronto.
```sql
SELECT colonne
FROM tabella1
JOIN tabella2
ON tabella1.colonna1 < tabella2.colonna2;
```
In questo esempio, i record di **tabella1** e **tabella2** saranno uniti quando il valore di colonna1 in **tabella1** è **minore** del valore di colonna2 in **tabella2**.

**Esempio di Theta Join**

Immagina di avere due tabelle:

**Tabella Dipendenti**

| id  | nome  | stipendio |
|-----|-------|-----------|
| 1   | Mario | 3000      |
| 2   | Luca  | 2500      |
| 3   | Anna  | 3500      |
**Tabella Progetti:**

| id_progetto | nome_progetto | budget |
| ----------- | ------------- | ------ |
| 101         | Sito Web      | 5000   |
| 102         | App Mobile    | 2000   |
| 103         | Software AI   | 7000   |
Supponiamo di voler unire queste due tabelle in base alla condizione che lo **stipendio** di un dipendente sia **maggiore del budget** di un progetto. La query con **theta join** sarebbe:
```sql 
SELECT Dipendenti.nome, Progetti.nome_progetto
FROM Dipendenti
JOIN Progetti
ON Dipendenti.stipendio > Progetti.budget;
```

**Risultato**:

| nome  | nome_progetto  |
|-------|----------------|
| Mario | Sito Web       |
| Anna  | Software AI    |

In questo caso, il **theta join** unisce le due tabelle in base alla condizione che **stipendio** di **Dipendenti** sia maggiore di **budget** di **Progetti**. Non stiamo utilizzando un’uguaglianza, ma un confronto di grandezza.

**Caratteristiche del Theta Join**
• **Flessibilità**: Può essere utilizzato con una vasta gamma di operatori di confronto (maggiore, minore, diverso, ecc.), non solo con l’uguaglianza.
• **Maggiore complessità**: Rispetto agli altri tipi di join, il **theta join** è più flessibile, ma può risultare meno intuitivo e più difficile da comprendere se non gestito correttamente.

**Differenze tra Theta Join e Altri Join**

• **Theta Join vs Equi Join**: L’**equi join** è un caso particolare di **theta join**, dove l’operatore di confronto è un’uguaglianza (=). Quindi, un **theta join** è più generale, mentre un **equi join** è un tipo specifico di **theta join**.
• **Theta Join vs Natural Join**: Il **natural join** unisce due tabelle utilizzando automaticamente tutte le colonne con lo stesso nome in entrambe le tabelle, mentre un **theta join** ti permette di specificare qualsiasi tipo di condizione di confronto tra le colonne, indipendentemente dai loro nomi.

**Quando usare il Theta Join**
Il **theta join** è utile quando si desidera unire tabelle utilizzando una condizione di confronto che non è una semplice uguaglianza. Alcuni esempi di applicazioni pratiche potrebbero includere:
• **Confronti di intervalli** (ad esempio, unire tabelle di vendite con tabelle di prezzi, dove il prezzo rientra in un intervallo di valori).
• **Combinare dati in base a relazioni non direttamente equivalenti**, come quando si vuole fare un join tra tabelle in base a una relazione di grandezza (ad esempio, unire tabelle di prodotti e magazzino dove un certo quantitativo di magazzino è sufficiente per soddisfare una certa condizione di vendita).

**Conclusione**
Il **theta join** è uno strumento potente che offre maggiore flessibilità nei confronti tra colonne di tabelle, consentendo di utilizzare qualsiasi operatore di confronto invece di limitarsi all’uguaglianza. Questo lo rende utile in una varietà di scenari dove la condizione di unione va oltre la semplice uguaglianza.