Class Esports.Tournament Extends %Persistent
{

Property title As %String(MINLEN = 5, MAXLEN = 100) [ Required ];

Property start As %Date;

Property end As %Date;

Property prize As %Integer(MINVAL = 0);

Relationship matches As Esports.Match [ Cardinality = children, Inverse = tournament ];

}
