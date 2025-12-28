Class Esports.Entity Extends %RegisteredObject [ Abstract ]
{

Property name As %String(MINLEN = 2, MAXLEN = 50) [ Required ];

Property created As %Date;

Method info() As %String
{
    Quit ..name
}

}
