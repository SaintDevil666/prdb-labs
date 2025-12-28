# Лабораторна 7: Web-технології

Кіберспортивна ліга

CSP-сторінки для CRUD, REST API та SOAP веб-сервіс.

## CSP CRUD

`player_page.csp` — повний CRUD для гравців:
- Список всіх гравців з таблиці Player
- Форма для створення нового гравця (nick, country, rating)
- Редагування існуючого гравця
- Видалення з підтвердженням

Прямий доступ до БД через `##class(Esports.Player)` та SQL-запити в CSP.

## REST API

Брокер `rest_broker.cls` з маршрутами:
- `GET /players` — список всіх гравців (JSON)
- `GET /player/:id` — один гравець
- `POST /player` — створення
- `PUT /player/:id` — оновлення
- `DELETE /player/:id` — видалення

Клієнт `rest_client.cls` демонструє виклики всіх ендпоінтів через `%Net.HttpRequest`.

## SOAP сервіс

`soap_svc.cls` надає методи:
- `get_all()` — список гравців
- `get_one(id)` — один гравець
- `create(nick, country, rating)` — створення

Клієнт `soap_client.cls` викликає сервіс через SOAP-запити.

![CSP список гравців](img/1.png)

![REST API відповіді](img/2.png)

![SOAP клієнт](img/3.png)
