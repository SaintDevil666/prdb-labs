Class Esports.PopulateData
{

ClassMethod Run()
{
    Do ##class(Esports.Tournament).%KillExtent()
    Do ##class(Esports.Player).%KillExtent()
    Do ##class(Esports.Team).%KillExtent()

    Write "[creating teams with players]",!
    Do ..fill_teams_and_players()
    Write !,"[creating tournaments with matches]",!
    Do ..fill_tournaments()
    Write !,"[done]",!
}

ClassMethod fill_teams_and_players()
{
    // NaVi
    Set navi = ##class(Esports.Team).%New()
    Set navi.name = "Natus Vincere", navi.founded = 2009, navi.created = $ZDateH("2009-12-17", 3)
    Do navi.games.Insert("CS2"), navi.games.Insert("Dota 2"), navi.games.Insert("Valorant")
    If $$$ISOK(navi.%Save()) Write "team:",navi.%Id(),":",navi.name,!

    // Vitality
    Set vitality = ##class(Esports.Team).%New()
    Set vitality.name = "Team Vitality", vitality.founded = 2013, vitality.created = $ZDateH("2013-08-01", 3)
    Do vitality.games.Insert("CS2"), vitality.games.Insert("LoL"), vitality.games.Insert("Rocket League")
    If $$$ISOK(vitality.%Save()) Write "team:",vitality.%Id(),":",vitality.name,!

    // G2
    Set g2 = ##class(Esports.Team).%New()
    Set g2.name = "G2 Esports", g2.founded = 2014, g2.created = $ZDateH("2014-02-24", 3)
    Do g2.games.Insert("CS2"), g2.games.Insert("LoL"), g2.games.Insert("Valorant")
    If $$$ISOK(g2.%Save()) Write "team:",g2.%Id(),":",g2.name,!

    // FaZe
    Set faze = ##class(Esports.Team).%New()
    Set faze.name = "FaZe Clan", faze.founded = 2010, faze.created = $ZDateH("2010-05-30", 3)
    Do faze.games.Insert("CS2"), faze.games.Insert("CoD"), faze.games.Insert("Fortnite")
    If $$$ISOK(faze.%Save()) Write "team:",faze.%Id(),":",faze.name,!

    Write !

    // p1: s1mple (NaVi)
    Set p1 = ##class(Esports.Player).%New()
    Set p1.name = "Oleksandr Kostyliev", p1.nick = "s1mple", p1.country = "Ukraine"
    Set p1.rating = 9500, p1.created = $ZDateH("2014-01-01", 3)
    Set p1.stats.wins = 850, p1.stats.losses = 320, p1.stats.kd = 1.28
    Do p1.bio.WriteLine("Oleksandr 's1mple' Kostyliev is a Ukrainian professional CS player.")
    Do p1.bio.WriteLine("Widely regarded as one of the greatest players in CS history.")
    Do p1.bio.WriteLine("Won PGL Major Antwerp 2022 and Intel Grand Slam Season 3.")
    Set p1.team = navi
    If $$$ISOK(p1.%Save()) Write "player:",p1.%Id(),":",p1.nick,!

    // p2: b1t (NaVi)
    Set p2 = ##class(Esports.Player).%New()
    Set p2.name = "Valerii Vakhovskyi", p2.nick = "b1t", p2.country = "Ukraine"
    Set p2.rating = 8200, p2.created = $ZDateH("2020-06-01", 3)
    Set p2.stats.wins = 320, p2.stats.losses = 180, p2.stats.kd = 1.15
    Do p2.bio.WriteLine("Valerii 'b1t' Vakhovskyi joined NaVi in 2020 as a young talent.")
    Do p2.bio.WriteLine("Known for his clutch plays and rifle skills.")
    Set p2.team = navi
    If $$$ISOK(p2.%Save()) Write "player:",p2.%Id(),":",p2.nick,!

    // p3: jL (NaVi)
    Set p3 = ##class(Esports.Player).%New()
    Set p3.name = "Justinas Lekavicius", p3.nick = "jLe", p3.country = "Lithuania"
    Set p3.rating = 7900, p3.created = $ZDateH("2023-09-01", 3)
    Set p3.stats.wins = 95, p3.stats.losses = 55, p3.stats.kd = 1.12
    Do p3.bio.WriteLine("Justinas 'jLe' Lekavicius is a Lithuanian rifler who joined NaVi in 2023.")
    Do p3.bio.WriteLine("Previously played for ENCE and Apeks.")
    Set p3.team = navi
    If $$$ISOK(p3.%Save()) Write "player:",p3.%Id(),":",p3.nick,!

    // p4: ZywOo (Vitality)
    Set p4 = ##class(Esports.Player).%New()
    Set p4.name = "Mathieu Herbaut", p4.nick = "ZywOo", p4.country = "France"
    Set p4.rating = 9400, p4.created = $ZDateH("2017-01-01", 3)
    Set p4.stats.wins = 380, p4.stats.losses = 120, p4.stats.kd = 1.38
    Do p4.bio.WriteLine("Mathieu 'ZywOo' Herbaut is a French professional CS player.")
    Do p4.bio.WriteLine("Two-time HLTV Player of the Year (2019, 2020).")
    Do p4.bio.WriteLine("Known for his exceptional AWP skills and clutch plays.")
    Set p4.team = vitality
    If $$$ISOK(p4.%Save()) Write "player:",p4.%Id(),":",p4.nick,!

    // p5: apEX (Vitality)
    Set p5 = ##class(Esports.Player).%New()
    Set p5.name = "Dan Madesclaire", p5.nick = "apEX", p5.country = "France"
    Set p5.rating = 7600, p5.created = $ZDateH("2012-06-01", 3)
    Set p5.stats.wins = 650, p5.stats.losses = 420, p5.stats.kd = 1.02
    Do p5.bio.WriteLine("Dan 'apEX' Madesclaire is Team Vitality's IGL.")
    Do p5.bio.WriteLine("A veteran French player with Major championship experience.")
    Set p5.team = vitality
    If $$$ISOK(p5.%Save()) Write "player:",p5.%Id(),":",p5.nick,!

    // p6: NiKo (G2)
    Set p6 = ##class(Esports.Player).%New()
    Set p6.name = "Nikola Kovac", p6.nick = "NiKo", p6.country = "Bosnia"
    Set p6.rating = 9100, p6.created = $ZDateH("2012-01-01", 3)
    Set p6.stats.wins = 920, p6.stats.losses = 480, p6.stats.kd = 1.22
    Do p6.bio.WriteLine("Nikola 'NiKo' Kovac is a Bosnian CS legend.")
    Do p6.bio.WriteLine("One of the most mechanically skilled players in CS history.")
    Do p6.bio.WriteLine("Has been competing at the highest level since 2012.")
    Set p6.team = g2
    If $$$ISOK(p6.%Save()) Write "player:",p6.%Id(),":",p6.nick,!

    // p7: huNter (G2)
    Set p7 = ##class(Esports.Player).%New()
    Set p7.name = "Nemanja Kovac", p7.nick = "huNter", p7.country = "Bosnia"
    Set p7.rating = 8700, p7.created = $ZDateH("2016-01-01", 3)
    Set p7.stats.wins = 420, p7.stats.losses = 230, p7.stats.kd = 1.15
    Do p7.bio.WriteLine("Nemanja 'huNter' Kovac is G2's rifler and NiKo's cousin.")
    Do p7.bio.WriteLine("A consistent fragger known for his reliability in clutch situations.")
    Do p7.bio.WriteLine("Has been a core part of G2's roster since 2019.")
    Set p7.team = g2
    If $$$ISOK(p7.%Save()) Write "player:",p7.%Id(),":",p7.nick,!

    // p8: karrigan (FaZe)
    Set p8 = ##class(Esports.Player).%New()
    Set p8.name = "Finn Andersen", p8.nick = "karrigan", p8.country = "Denmark"
    Set p8.rating = 7200, p8.created = $ZDateH("2010-01-01", 3)
    Set p8.stats.wins = 1100, p8.stats.losses = 750, p8.stats.kd = 0.95
    Do p8.bio.WriteLine("Finn 'karrigan' Andersen is FaZe Clan's IGL (in-game leader).")
    Do p8.bio.WriteLine("A veteran with over 14 years of professional experience.")
    Do p8.bio.WriteLine("Known for tactical genius despite lower individual stats.")
    Set p8.team = faze
    If $$$ISOK(p8.%Save()) Write "player:",p8.%Id(),":",p8.nick,!
}

ClassMethod fill_tournaments()
{
    Set navi_id = ..get_team_id("Natus Vincere")
    Set vitality_id = ..get_team_id("Team Vitality")
    Set g2_id = ..get_team_id("G2 Esports")
    Set faze_id = ..get_team_id("FaZe Clan")

    Set s1mple_id = ..get_player_id("s1mple")
    Set b1t_id = ..get_player_id("b1t")
    Set zywoo_id = ..get_player_id("ZywOo")
    Set niko_id = ..get_player_id("NiKo")
    Set hunter_id = ..get_player_id("huNter")
    Set karrigan_id = ..get_player_id("karrigan")

    // PGL Major Copenhagen 2024
    Set major = ##class(Esports.Tournament).%New()
    Set major.title = "PGL Major Copenhagen 2024", major.prize = 1250000
    Set major.start = $ZDateH("2024-03-17", 3), major.end = $ZDateH("2024-03-31", 3)
    If $$$ISOK(major.%Save()) Write "trn:",major.%Id(),":",major.title,!

    Set m1 = ##class(Esports.Match).%New()
    Set m1.num = 1, m1.played = $ZDateH("2024-03-20", 3), m1.tournament = major
    Do m1.scores.SetAt(16, "Mirage"), m1.scores.SetAt(13, "Inferno")
    Do m1.team_aSetObjectId(navi_id), m1.team_bSetObjectId(vitality_id)
    Do m1.mvpSetObjectId(s1mple_id)
    If $$$ISOK(m1.%Save()) Write "  match:",m1.num," mvp:s1mple",!

    Set m2 = ##class(Esports.Match).%New()
    Set m2.num = 2, m2.played = $ZDateH("2024-03-25", 3), m2.tournament = major
    Do m2.scores.SetAt(13, "Anubis"), m2.scores.SetAt(16, "Nuke"), m2.scores.SetAt(19, "Ancient")
    Do m2.team_aSetObjectId(g2_id), m2.team_bSetObjectId(navi_id)
    Do m2.mvpSetObjectId(niko_id)
    If $$$ISOK(m2.%Save()) Write "  match:",m2.num," mvp:NiKo",!

    Set m3 = ##class(Esports.Match).%New()
    Set m3.num = 3, m3.played = $ZDateH("2024-03-30", 3), m3.tournament = major
    Do m3.scores.SetAt(16, "Vertigo"), m3.scores.SetAt(14, "Overpass"), m3.scores.SetAt(16, "Nuke")
    Do m3.team_aSetObjectId(vitality_id), m3.team_bSetObjectId(faze_id)
    Do m3.mvpSetObjectId(zywoo_id)
    If $$$ISOK(m3.%Save()) Write "  match:",m3.num," mvp:ZywOo",!

    // IEM Katowice 2024
    Set iem = ##class(Esports.Tournament).%New()
    Set iem.title = "IEM Katowice 2024", iem.prize = 1000000
    Set iem.start = $ZDateH("2024-01-31", 3), iem.end = $ZDateH("2024-02-11", 3)
    If $$$ISOK(iem.%Save()) Write "trn:",iem.%Id(),":",iem.title,!

    Set m4 = ##class(Esports.Match).%New()
    Set m4.num = 1, m4.played = $ZDateH("2024-02-05", 3), m4.tournament = iem
    Do m4.scores.SetAt(16, "Dust2"), m4.scores.SetAt(14, "Vertigo")
    Do m4.team_aSetObjectId(vitality_id), m4.team_bSetObjectId(g2_id)
    Do m4.mvpSetObjectId(hunter_id)
    If $$$ISOK(m4.%Save()) Write "  match:",m4.num," mvp:huNter",!

    Set m5 = ##class(Esports.Match).%New()
    Set m5.num = 2, m5.played = $ZDateH("2024-02-11", 3), m5.tournament = iem
    Do m5.scores.SetAt(16, "Mirage"), m5.scores.SetAt(10, "Inferno"), m5.scores.SetAt(16, "Overpass")
    Do m5.team_aSetObjectId(navi_id), m5.team_bSetObjectId(faze_id)
    Do m5.mvpSetObjectId(b1t_id)
    If $$$ISOK(m5.%Save()) Write "  match:",m5.num," mvp:b1t",!

    // BLAST Premier
    Set blast = ##class(Esports.Tournament).%New()
    Set blast.title = "BLAST Premier Fall Final 2024", blast.prize = 500000
    Set blast.start = $ZDateH("2024-11-20", 3), blast.end = $ZDateH("2024-11-24", 3)
    If $$$ISOK(blast.%Save()) Write "trn:",blast.%Id(),":",blast.title,!

    Set m6 = ##class(Esports.Match).%New()
    Set m6.num = 1, m6.played = $ZDateH("2024-11-22", 3), m6.tournament = blast
    Do m6.scores.SetAt(16, "Ancient"), m6.scores.SetAt(13, "Anubis")
    Do m6.team_aSetObjectId(faze_id), m6.team_bSetObjectId(vitality_id)
    Do m6.mvpSetObjectId(karrigan_id)
    If $$$ISOK(m6.%Save()) Write "  match:",m6.num," mvp:karrigan",!
}

ClassMethod get_team_id(team_name As %String) As %Integer
{
    &sql(SELECT ID INTO :id FROM Esports.Team WHERE name = :team_name)
    If SQLCODE = 0 Quit id
    Quit ""
}

ClassMethod get_player_id(nick As %String) As %Integer
{
    &sql(SELECT ID INTO :id FROM Esports.Player WHERE nick = :nick)
    If SQLCODE = 0 Quit id
    Quit ""
}

}
