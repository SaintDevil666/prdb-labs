Class Esports.Tests Extends %UnitTest.TestCase
{

Method OnAfterAllTests() As %Status
{
    Do ##class(Esports.Tournament).%KillExtent()
    Do ##class(Esports.Player).%KillExtent()
    Do ##class(Esports.Team).%KillExtent()
    Quit $$$OK
}

Method TestCreateTeam()
{
    Set t = ##class(Esports.Team).%New()
    Do $$$AssertTrue($IsObject(t), "obj")
    Set t.name = "Test", t.founded = 2020
    Do $$$AssertStatusOK(t.%Save(), "ok")
    Do $$$AssertNotEquals(t.%Id(), "", "id")
}

Method TestTeamRequired()
{
    Set t = ##class(Esports.Team).%New()
    Set t.founded = 2020
    Do $$$AssertStatusNotOK(t.%Save(), "req")
}

Method TestPlayerUnique()
{
    Set p1 = ##class(Esports.Player).%New()
    Set p1.nick = "uniq"
    Do $$$AssertStatusOK(p1.%Save(), "1st")
    Set p2 = ##class(Esports.Player).%New()
    Set p2.nick = "uniq"
    Do $$$AssertStatusNotOK(p2.%Save(), "dup")
}

Method TestPlayerConstraints()
{
    Set p = ##class(Esports.Player).%New()
    Set p.nick = "lo", p.rating = -100
    Do $$$AssertStatusNotOK(p.%Save(), "min")
    Set p2 = ##class(Esports.Player).%New()
    Set p2.nick = "hi", p2.rating = 15000
    Do $$$AssertStatusNotOK(p2.%Save(), "max")
    Set p3 = ##class(Esports.Player).%New()
    Set p3.nick = "ok", p3.rating = 5000
    Do $$$AssertStatusOK(p3.%Save(), "ok")
}

Method TestOneMany()
{
    Set t = ##class(Esports.Team).%New()
    Set t.name = "T1"
    Do t.%Save()
    For n = "a","b" {
        Set p = ##class(Esports.Player).%New()
        Set p.nick = "p"_n
        Do p.teamSetObjectId(t.%Id())
        Do p.%Save()
    }
    Set tr = ##class(Esports.Team).%OpenId(t.%Id())
    Do $$$AssertEquals(tr.players.Count(), 2, "cnt")
}

Method TestParentChildren()
{
    Set trn = ##class(Esports.Tournament).%New()
    Set trn.title = "Cup"
    Do trn.%Save()
    For i = 1:1:2 {
        Set m = ##class(Esports.Match).%New()
        Set m.num = i, m.tournament = trn
        Do m.%Save()
    }
    Set tr = ##class(Esports.Tournament).%OpenId(trn.%Id())
    Do $$$AssertEquals(tr.matches.Count(), 2, "cnt")
}

Method TestCascade()
{
    Set trn = ##class(Esports.Tournament).%New()
    Set trn.title = "Del"
    Do trn.%Save()
    Set tid = trn.%Id()
    Set m = ##class(Esports.Match).%New()
    Set m.num = 1, m.tournament = trn
    Do m.%Save()
    Set mid = m.%Id()
    Do $$$AssertStatusOK(##class(Esports.Tournament).%DeleteId(tid), "del")
    Do $$$AssertTrue('$IsObject(##class(Esports.Match).%OpenId(mid)), "gone")
}

Method TestNoDelWithPlayers()
{
    Set t = ##class(Esports.Team).%New()
    Set t.name = "ND"
    Do t.%Save()
    Set tid = t.%Id()
    Set p = ##class(Esports.Player).%New()
    Set p.nick = "nd"
    Do p.teamSetObjectId(tid)
    Do p.%Save()
    Do $$$AssertStatusNotOK(##class(Esports.Team).%DeleteId(tid), "ref")
}

Method TestWinRate()
{
    Set p = ##class(Esports.Player).%New()
    Set p.nick = "wr", p.stats.wins = 70, p.stats.losses = 30
    Do p.%Save()
    Set pr = ##class(Esports.Player).%OpenId(p.%Id())
    Do $$$AssertEquals(pr.win_rate, 70, "70")
}

Method TestPopulate()
{
    Do $$$AssertEquals(##class(Esports.Team).Populate(3,0), 3, "pop")
}

}
