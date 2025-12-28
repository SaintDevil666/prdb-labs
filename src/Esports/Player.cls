Class Esports.Player Extends (Esports.Entity, %Persistent, %Populate)
{

Property nick As %String(MAXLEN = 50, POPSPEC = "String(5)") [ Required ];

Index nick_idx On nick [ Unique ];

Property country As %String(MAXLEN = 50, POPSPEC = "USState()");

Property rating As %Integer(MAXVAL = 10000, MINVAL = 0, POPSPEC = "Integer(0,10000)");

Property bio As %Stream.GlobalCharacter;

Property stats As Esports.Stats;

Relationship team As Esports.Team [ Cardinality = one, Inverse = players ];

Index team_idx On team;

Property win_rate As %Float [ Calculated, SqlComputeCode = {set {win_rate} = ##class(Esports.Player).calc_wr({%%ID})}, SqlComputed ];

ClassMethod calc_wr(pid As %String) As %Float
{
    Set p = ##class(Esports.Player).%OpenId(pid)
    If '$IsObject(p) Quit 0
    Set t = p.stats.total()
    Quit $S(t=0:0, 1:$FN(p.stats.wins/t*100,"",2))
}

Method win_rateGet() As %Float
{
    Set t = ..stats.total()
    Quit $S(t=0:0, 1:$FN(..stats.wins/t*100,"",2))
}

Method bio_populate() As %Status
{
    Do ..bio.WriteLine(##class(%PopulateUtils).String(30))
    Quit $$$OK
}

Method stats_populate() As %Status
{
    Set ..stats.wins = $R(500), ..stats.losses = $R(300), ..stats.kd = $FN($R(150)/100+0.5,"",2)
    Quit $$$OK
}

Method team_populate() As %Status
{
    Set c = 0
    &sql(SELECT COUNT(*) INTO :c FROM Esports.Team)
    If c Do ..teamSetObjectId($R(c)+1)
    Quit $$$OK
}

Method info() As %String
{
    Quit ..nick _ " (" _ ..country _ ")"
}

}
