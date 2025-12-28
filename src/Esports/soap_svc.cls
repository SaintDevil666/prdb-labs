Class Esports.SoapService Extends %SOAP.WebService
{

Parameter SERVICENAME = "EsportsPlayerService";
Parameter NAMESPACE = "http://esports.kpi.ua/soap";
Parameter USECLASSNAMESPACES = 1;

Method get_all() As %ListOfObjects(ELEMENTTYPE="Esports.PlayerInfo") [ WebMethod ]
{
    Set r=##class(%ListOfObjects).%New() Set k="" For { Set k=$O(^Esports.PlayerD(k)) Q:k=""
        Set d=$G(^Esports.PlayerD(k)), i=##class(Esports.PlayerInfo).%New()
        Set i.id=k, i.nick=k, i.country=$LG(d,2), i.rating=$LG(d,3)
        Do r.Insert(i)
    }
    Q r
}

Method get_one(id As %String) As Esports.PlayerInfo [ WebMethod ]
{
    Set p=##class(Esports.Player).%OpenId(id) Q:'$IsObject(p) ""
    Set i=##class(Esports.PlayerInfo).%New()
    Set i.id=id, i.nick=p.nick, i.country=p.country, i.rating=p.rating
    Q i
}

Method create(nick As %String, country As %String, rating As %Integer) As %String [ WebMethod ]
{
    Set p=##class(Esports.Player).%New()
    Set p.nick=nick, p.country=country, p.rating=rating
    Set p.stats=##class(Esports.Stats).%New() Set p.stats.wins=0,p.stats.losses=0,p.stats.kd=1
    Set sc=p.%Save()
    Q $S($$$ISOK(sc):"ok:"_nick,1:"err:"_$System.Status.GetErrorText(sc))
}

Method update(id As %String, country As %String, rating As %Integer) As %String [ WebMethod ]
{
    Set p=##class(Esports.Player).%OpenId(id) Q:'$IsObject(p) "err:not found"
    If country'="" Set p.country=country
    If rating>0 Set p.rating=rating
    Set sc=p.%Save()
    Q $S($$$ISOK(sc):"ok:"_id,1:"err:"_$System.Status.GetErrorText(sc))
}

Method delete(id As %String) As %String [ WebMethod ]
{
    Set sc=##class(Esports.Player).%DeleteId(id)
    Q $S($$$ISOK(sc):"ok",1:"err:"_$System.Status.GetErrorText(sc))
}

}
