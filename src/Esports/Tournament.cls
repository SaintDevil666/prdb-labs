Class Esports.Tournament Extends (%Persistent, %Populate)
{

Property title As %String(MAXLEN = 200, POPSPEC = "Mission()") [ Required ];

Property start As %Date(POPSPEC = "Date()");

Property end As %Date(POPSPEC = "Date()");

Property prize As %Integer(POPSPEC = "Integer(10000,2000000)");

Relationship matches As Esports.Match [ Cardinality = children, Inverse = tournament ];

Query all() As %SQLQuery(CONTAINID = 1)
{
    SELECT %ID, title, start, end, prize FROM Esports.Tournament ORDER BY prize DESC
}

Query by_prize(min_p As %Integer) As %SQLQuery(CONTAINID = 1)
{
    SELECT %ID, title, prize FROM Esports.Tournament WHERE prize >= :min_p ORDER BY prize DESC
}

Query by_dates(d1 As %Date, d2 As %Date) As %Query(ROWSPEC = "id,title,start,prize")
{
}

ClassMethod by_datesExecute(ByRef h As %Binary, d1 As %Date, d2 As %Date) As %Status
{
    Set st=##class(%SQL.Statement).%New()
    Do st.%Prepare("SELECT %ID,title,start,prize FROM Esports.Tournament WHERE start>=? AND end<=? ORDER BY start")
    Set h("r")=st.%Execute(d1,d2) Q $$$OK
}

ClassMethod by_datesFetch(ByRef h As %Binary, ByRef Row As %List, ByRef AtEnd As %Integer = 0) As %Status [ PlaceAfter = by_datesExecute ]
{
    Set r=h("r") If r.%Next() { Set Row=$LB(r.%GetData(1),r.%GetData(2),r.%GetData(3),r.%GetData(4)) } Else { Set Row="",AtEnd=1 } Q $$$OK
}

ClassMethod by_datesClose(ByRef h As %Binary) As %Status [ PlaceAfter = by_datesExecute ]
{
    Kill h Q $$$OK
}

}
