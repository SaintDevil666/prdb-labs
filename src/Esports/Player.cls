Class Esports.Player Extends (Esports.Entity, %Persistent)
{

Property nick As %String(MINLEN = 3, MAXLEN = 20) [ Required ];

Index nick_idx On nick [ Unique ];

Property country As %String(MAXLEN = 30);

Property rating As %Integer(MAXVAL = 10000, MINVAL = 0);

Property bio As %Stream.GlobalCharacter;

Property stats As Esports.Stats;

Relationship team As Esports.Team [ Cardinality = one, Inverse = players ];

Index team_idx On team;

Method info() As %String
{
    Quit ..nick _ " (" _ ..country _ ")"
}

}
