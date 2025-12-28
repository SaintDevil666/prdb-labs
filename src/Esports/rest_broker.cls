Class Esports.RestBroker Extends %CSP.REST
{

Parameter CONTENTTYPE = "application/json";
Parameter CHARSET = "utf-8";
Parameter HandleCorsRequest = 1;

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
    <Route Url="/players" Method="GET" Call="get_all"/>
    <Route Url="/player/:id" Method="GET" Call="get_one"/>
    <Route Url="/player" Method="POST" Call="create"/>
    <Route Url="/player/:id" Method="PUT" Call="update"/>
    <Route Url="/player/:id" Method="DELETE" Call="delete"/>
</Routes>
}

ClassMethod get_all() As %Status
{
    Set a=[] Set k="" For { Set k=$O(^Esports.PlayerD(k)) Q:k=""
        Set d=$G(^Esports.PlayerD(k)), o={}
        Set o.id=k, o.nick=k, o.country=$LG(d,2), o.rating=$LG(d,3)
        Do a.%Push(o)
    }
    Write a.%ToJSON() Q $$$OK
}

ClassMethod get_one(id) As %Status
{
    Set p=##class(Esports.Player).%OpenId(id)
    If '$IsObject(p) { Set %response.Status="404" Write {"error":"not found"}.%ToJSON() Q $$$OK }
    Set r={}, r.id=id, r.nick=p.nick, r.country=p.country, r.rating=p.rating, r.win_rate=p.win_rate
    Write r.%ToJSON() Q $$$OK
}

ClassMethod create() As %Status
{
    Set d=##class(%DynamicObject).%FromJSON(%request.Content)
    Set p=##class(Esports.Player).%New()
    Set p.nick=d.nick, p.country=d.country, p.rating=d.rating
    Set p.stats=##class(Esports.Stats).%New() Set p.stats.wins=0,p.stats.losses=0,p.stats.kd=1
    Set sc=p.%Save()
    If $$$ISERR(sc) { Set %response.Status="400" Write {"error":($System.Status.GetErrorText(sc))}.%ToJSON() Q $$$OK }
    Set %response.Status="201" Write {"id":(p.nick),"msg":"created"}.%ToJSON() Q $$$OK
}

ClassMethod update(id) As %Status
{
    Set p=##class(Esports.Player).%OpenId(id)
    If '$IsObject(p) { Set %response.Status="404" Write {"error":"not found"}.%ToJSON() Q $$$OK }
    Set d=##class(%DynamicObject).%FromJSON(%request.Content)
    If d.country'="" Set p.country=d.country
    If d.rating'="" Set p.rating=d.rating
    Set sc=p.%Save()
    If $$$ISERR(sc) { Set %response.Status="400" Write {"error":($System.Status.GetErrorText(sc))}.%ToJSON() Q $$$OK }
    Write {"id":(id),"msg":"updated"}.%ToJSON() Q $$$OK
}

ClassMethod delete(id) As %Status
{
    Set sc=##class(Esports.Player).%DeleteId(id)
    If $$$ISERR(sc) { Set %response.Status="400" Write {"error":($System.Status.GetErrorText(sc))}.%ToJSON() Q $$$OK }
    Write {"msg":"deleted"}.%ToJSON() Q $$$OK
}

}
