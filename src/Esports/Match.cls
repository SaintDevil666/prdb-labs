Class Esports.Match Extends (%Persistent, %Populate)
{

Property num As %Integer(POPSPEC = "Integer(1,100)");

Property played As %Date(POPSPEC = "Date()");

Property scores As array Of %Integer;

Property team_a As Esports.Team;

Property team_b As Esports.Team;

Relationship tournament As Esports.Tournament [ Cardinality = parent, Inverse = matches ];

Method scores_populate() As %Status
{
    Set m=$LB("Mirage","Inferno","Dust2","Nuke","Ancient")
    For i=1:1:$R(3)+1 Do ..scores.SetAt($R(16)+1,$LI(m,i))
    Q $$$OK
}

Method team_a_populate() As %Status
{
    Set c=0 &sql(SELECT COUNT(*) INTO :c FROM Esports.Team) If c Do ..team_aSetObjectId($R(c)+1) Q $$$OK
}

Method team_b_populate() As %Status
{
    Set c=0 &sql(SELECT COUNT(*) INTO :c FROM Esports.Team) If c Do ..team_bSetObjectId($R(c)+1) Q $$$OK
}

Query all() As %SQLQuery(CONTAINID = 1)
{
    SELECT %ID, num, played, tournament FROM Esports.Match ORDER BY played DESC
}

Query with_teams() As %SQLQuery(CONTAINID = 1)
{
    SELECT %ID, num, tournament->title tt, team_a->name t1, team_b->name t2 FROM Esports.Match ORDER BY tournament->title
}

}
