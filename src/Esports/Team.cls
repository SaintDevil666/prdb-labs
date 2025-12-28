Class Esports.Team Extends (%Persistent, %Populate)
{

Property name As %String(MAXLEN = 100, POPSPEC = "Company()") [ Required ];

Property founded As %Integer(POPSPEC = "Integer(2000,2024)");

Property games As list Of %String;

Relationship players As Esports.Player [ Cardinality = many, Inverse = team ];

Method games_populate() As %Status
{
    Set g = $LB("CS2", "Dota 2", "Valorant", "LoL", "Apex")
    For i = 1:1:$Random(3)+1 Do ..games.Insert($LI(g, $Random($LL(g))+1))
    Quit $$$OK
}

}
