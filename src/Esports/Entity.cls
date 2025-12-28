Class Esports.Entity Extends %RegisteredObject [ Abstract ]
{

Property name As %String(MAXLEN = 100, POPSPEC = "Name()");

Property created As %Date(POPSPEC = "Date()");

Method info() As %String
{
    Quit ..name
}

}
