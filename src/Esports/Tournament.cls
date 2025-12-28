Class Esports.Tournament Extends (%Persistent, %Populate)
{

Property title As %String(MAXLEN = 200, POPSPEC = "Mission()") [ Required ];

Property start As %Date(POPSPEC = "Date()");

Property end As %Date(POPSPEC = "Date()");

Property prize As %Integer(POPSPEC = "Integer(10000,2000000)");

Relationship matches As Esports.Match [ Cardinality = children, Inverse = tournament ];

}
