Class Esports.Player Extends (Esports.Entity, %Persistent, %Populate)
{

Property nick As %String(MAXLEN = 50, POPSPEC = "String(5)") [ Required ];

Index nick_idx On nick [ IdKey, Unique ];

Property country As %String(MAXLEN = 50, POPSPEC = "USState()");

Property rating As %Integer(MAXVAL = 10000, MINVAL = 0, POPSPEC = "Integer(0,10000)");

Property bio As %Stream.GlobalCharacter;

Property stats As Esports.Stats;

Relationship team As Esports.Team [ Cardinality = one, Inverse = players ];

Index team_idx On team;

Property win_rate As %Float [ Calculated, SqlComputeCode = {set {win_rate}=##class(Esports.Player).wr({%%ID})}, SqlComputed ];

ClassMethod wr(id) As %Float
{
    Set o=##class(Esports.Player).%OpenId(id) Q:'$IsObject(o) 0
    Set t=o.stats.total() Q:t=0 0 Q $FN(o.stats.wins/t*100,"",2)
}

Method win_rateGet() As %Float
{
    Set t=..stats.total() Q:t=0 0 Q $FN(..stats.wins/t*100,"",2)
}

Method bio_populate() As %Status
{
    Do ..bio.WriteLine(##class(%PopulateUtils).String(30)) Q $$$OK
}

Method stats_populate() As %Status
{
    Set ..stats.wins=$R(500), ..stats.losses=$R(300), ..stats.kd=$FN($R(150)/100+0.5,"",2) Q $$$OK
}

Method team_populate() As %Status
{
    Set c=0 &sql(SELECT COUNT(*) INTO :c FROM Esports.Team)
    If c Do ..teamSetObjectId($R(c)+1)
    Q $$$OK
}

Method info() As %String
{
    Q ..nick_" ("_..country_")"
}

Query all_players() As %SQLQuery(CONTAINID = 1)
{
    SELECT %ID, nick, country, rating FROM Esports.Player ORDER BY rating DESC
}

Query by_rating(min_r As %Integer) As %SQLQuery(CONTAINID = 1)
{
    SELECT %ID, nick, country, rating, team->name t FROM Esports.Player WHERE rating >= :min_r ORDER BY rating DESC
}

Query with_team() As %SQLQuery(CONTAINID = 1)
{
    SELECT %ID, nick, rating, team->name t, team->founded y FROM Esports.Player ORDER BY team->name
}

Trigger log_chg [ Event = INSERT/UPDATE, Foreach = row/object, Time = AFTER ]
{
    Set ^esports_log("player",{%%ID},{%%OPERATION},$ZTS)={nick}
}

}
