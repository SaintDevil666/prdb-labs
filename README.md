# Лабораторна 8: MongoDB

Кіберспортивна ліга

Реалізація моделі даних з ПР3 у MongoDB з Java-клієнтом.

## База даних

```
esports_db/
├── teams        — команди (normalized)
├── players      — гравці з team_id (one-many)
└── tournaments  — турніри з embedded матчами (parent-children)
```

## Моделі зберігання

**Normalized** (players → teams): гравець зберігає `team_id` як посилання на команду. Це реалізує one-many зв'язок з ПР3.

**Embedded** (tournaments.matches): матчі вбудовані в документ турніру як масив. Це реалізує parent-children зв'язок — видалення турніру автоматично видаляє матчі.

Кожна колекція містить 4+ документів (команди NaVi, Team Liquid, Fnatic, G2; гравці s1mple, NiKo, dev1ce, ZywOo, b1t; турніри Major Stockholm, ESL Pro League, BLAST Premier, IEM Katowice).

## Java-клієнт

Клас `EsportsApp.java` демонструє:

**Вивід всіх документів** — ітерація по кожній колекції через `find()`.

**Запит з фільтром** — пошук українських гравців з рейтингом > 9000:
```java
Filters.and(Filters.gt("rating", 9000), Filters.eq("country", "UA"))
```

**Агрегація** — статистика гравців по командах з 5 етапами:
1. `$lookup` — join players з teams
2. `$unwind` — розгортання team_info
3. `$group` — групування по team.name з підрахунком гравців та avg rating
4. `$sort` — сортування за кількістю гравців
5. `$project` — форматування виводу

![Колекції MongoDB](img/1.png)

![Java: документи, запит та агрегація](img/2.png)
