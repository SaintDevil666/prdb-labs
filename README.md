# Лабораторна 4: Класи IRIS

Кіберспортивна ліга

Реалізація UML-діаграми з ПР3 як класів InterSystems IRIS ObjectScript.

## Структура проекту

```
src/Esports/
├── Entity.cls       — абстрактний базовий клас
├── Stats.cls        — serial-клас статистики
├── Player.cls       — гравець (extends Entity)
├── Team.cls         — команда (extends Entity)
├── Tournament.cls   — турнір
├── Match.cls        — матч (child of Tournament)
└── PopulateData.cls — заповнення тестовими даними
```

## Заповнення даних

```objectscript
Do ##class(Esports.PopulateData).Run()
```

Скрипт створює 4 команди (NaVi, Vitality, G2, FaZe), 8 гравців з реальними нікнеймами та статистикою, 3 турніри (PGL Major Copenhagen, IEM Katowice, BLAST Premier) та 6 матчів з прив'язкою до турнірів.

## Створені об'єкти

| Клас | К-сть | Приклади |
|------|-------|----------|
| Team | 4 | NaVi, Vitality, G2, FaZe |
| Player | 8 | s1mple, b1t, ZywOo, apEX, NiKo, huNter... |
| Tournament | 3 | PGL Major Copenhagen, IEM Katowice, BLAST |
| Match | 6 | Матчі з посиланнями на команди та MVP |

## Зв'язки

Кожен гравець прив'язаний до команди (one-many). Матчі є children турнірів (parent-children). У матчі посилання на дві команди-учасниці та MVP-гравця.

![Виконання PopulateData](img/1.png)

![Таблиця Player](img/2.png)

![Таблиця Match з посиланнями](img/3.png)
