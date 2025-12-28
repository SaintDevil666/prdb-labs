Class Esports.Team Extends (Esports.Entity, %Persistent)
{

Property founded As %Integer(MAXVAL = 2100, MINVAL = 1990);

Property games As list Of %String;

Relationship players As Esports.Player [ Cardinality = many, Inverse = team ];

Method total_players() As %Integer
{
    Quit ..players.Count()
}

}
