// MongoDB init script - Esports DB
// Variant 10: Style B (snake_case, compact)

use esports_db

db.teams.drop()
db.players.drop()
db.tournaments.drop()

// === NORMALIZED: teams ===
db.teams.insertMany([
    { _id: "t1", name: "Natus Vincere", founded: 2009, games: ["CS2", "Dota 2"] },
    { _id: "t2", name: "Team Liquid", founded: 2000, games: ["CS2", "Valorant", "LoL"] },
    { _id: "t3", name: "Fnatic", founded: 2004, games: ["CS2", "Valorant"] },
    { _id: "t4", name: "G2 Esports", founded: 2013, games: ["CS2", "LoL", "Valorant"] }
])

// === NORMALIZED: players (ref to team_id) ===
db.players.insertMany([
    { _id: "p1", nick: "s1mple", country: "UA", rating: 9500, team_id: "t1",
      stats: { wins: 450, losses: 120, kd: 1.35 } },
    { _id: "p2", nick: "NiKo", country: "BA", rating: 9200, team_id: "t4",
      stats: { wins: 380, losses: 150, kd: 1.28 } },
    { _id: "p3", nick: "dev1ce", country: "DK", rating: 9100, team_id: "t2",
      stats: { wins: 410, losses: 130, kd: 1.22 } },
    { _id: "p4", nick: "ZywOo", country: "FR", rating: 9400, team_id: "t2",
      stats: { wins: 320, losses: 100, kd: 1.40 } },
    { _id: "p5", nick: "b1t", country: "UA", rating: 8800, team_id: "t1",
      stats: { wins: 280, losses: 140, kd: 1.18 } }
])

// === EMBEDDED: tournaments (contains matches) ===
db.tournaments.insertMany([
    {
        _id: "tour1", title: "Major Stockholm 2024", prize: 1250000,
        start: new Date("2024-10-01"), end: new Date("2024-10-15"),
        matches: [
            { num: 1, team_a: "t1", team_b: "t2", scores: { map1: 16, map2: 14 } },
            { num: 2, team_a: "t3", team_b: "t4", scores: { map1: 16, map2: 12 } },
            { num: 3, team_a: "t1", team_b: "t4", scores: { map1: 16, map2: 10 } }
        ]
    },
    {
        _id: "tour2", title: "ESL Pro League S19", prize: 850000,
        start: new Date("2024-08-15"), end: new Date("2024-09-01"),
        matches: [
            { num: 1, team_a: "t2", team_b: "t3", scores: { map1: 16, map2: 9 } },
            { num: 2, team_a: "t1", team_b: "t3", scores: { map1: 16, map2: 13 } }
        ]
    },
    {
        _id: "tour3", title: "BLAST Premier Fall", prize: 500000,
        start: new Date("2024-11-01"), end: new Date("2024-11-10"),
        matches: [
            { num: 1, team_a: "t4", team_b: "t1", scores: { map1: 14, map2: 16 } }
        ]
    },
    {
        _id: "tour4", title: "IEM Katowice 2024", prize: 1000000,
        start: new Date("2024-02-01"), end: new Date("2024-02-12"),
        matches: [
            { num: 1, team_a: "t1", team_b: "t2", scores: { map1: 16, map2: 11 } },
            { num: 2, team_a: "t3", team_b: "t4", scores: { map1: 13, map2: 16 } }
        ]
    }
])

print("esports_db initialized: teams(4), players(5), tournaments(4)")
