Class Esports.Team Extends (%Persistent, %Populate)
{

Property name As %String(MAXLEN = 100, POPSPEC = "Company()") [ Required ];

Property founded As %Integer(POPSPEC = "Integer(2000,2024)");

Property games As list Of %String;

Relationship players As Esports.Player [ Cardinality = many, Inverse = team ];

Method games_populate() As %Status
{
    Set g=$LB("CS2","Dota 2","Valorant","LoL","Apex")
    For i=1:1:$R(3)+1 Do ..games.Insert($LI(g,$R($LL(g))+1))
    Q $$$OK
}

Query all() As %SQLQuery(CONTAINID = 1)
{
    SELECT %ID, name, founded FROM Esports.Team ORDER BY name
}

Query by_year(y As %Integer) As %SQLQuery(CONTAINID = 1)
{
    SELECT %ID, name, founded FROM Esports.Team WHERE founded >= :y ORDER BY founded DESC
}

}
