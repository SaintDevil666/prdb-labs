Class Esports.Setup Extends %RegisteredObject
{

ClassMethod clr()
{
    Do ##class(Esports.Match).%KillExtent()
    Do ##class(Esports.Tournament).%KillExtent()
    Do ##class(Esports.Player).%KillExtent()
    Do ##class(Esports.Team).%KillExtent()
    Kill ^esports_log
}

ClassMethod gen(n As %Integer = 3)
{
    Do ##class(Esports.Team).Populate(n)
    Do ##class(Esports.Player).Populate(n*2)
    Do ##class(Esports.Tournament).Populate(n)
    Do ..genm(n*3)
}

ClassMethod genm(n As %Integer)
{
    Set tc=0 &sql(SELECT COUNT(*) INTO :tc FROM Esports.Tournament) Q:tc=0
    Set team_c=0 &sql(SELECT COUNT(*) INTO :team_c FROM Esports.Team)
    For i=1:1:n {
        Set t=##class(Esports.Tournament).%OpenId($R(tc)+1) Continue:'$IsObject(t)
        Set m=##class(Esports.Match).%New()
        Set m.num=i, m.played=$H-$R(365)
        Do m.scores_populate()
        If team_c Do m.team_aSetObjectId($R(team_c)+1), m.team_bSetObjectId($R(team_c)+1)
        Set m.tournament=t
        Do m.%Save()
    }
}

ClassMethod reset(n As %Integer = 3)
{
    Write "Reset...", !
    Do ..clr(), ..gen(n), ..stat()
}

ClassMethod stat()
{
    New c
    &sql(SELECT COUNT(*) INTO :c FROM Esports.Team) Write "Teams: "_c, !
    &sql(SELECT COUNT(*) INTO :c FROM Esports.Player) Write "Players: "_c, !
    &sql(SELECT COUNT(*) INTO :c FROM Esports.Tournament) Write "Tournaments: "_c, !
    &sql(SELECT COUNT(*) INTO :c FROM Esports.Match) Write "Matches: "_c, !
}

ClassMethod glob()
{
    Write "^Esports.PlayerD:", ! ZWrite ^Esports.PlayerD
    Write ! Write "^Esports.PlayerI:", ! ZWrite ^Esports.PlayerI
}

}
