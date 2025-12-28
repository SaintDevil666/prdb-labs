Class Esports.Match Extends %Persistent
{

Property num As %Integer;

Property played As %Date;

Property scores As array Of %Integer;

Property team_a As Esports.Team;

Property team_b As Esports.Team;

Property mvp As Esports.Player;

Relationship tournament As Esports.Tournament [ Cardinality = parent, Inverse = matches ];

}
