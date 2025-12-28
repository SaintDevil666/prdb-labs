Class Esports.SoapClient Extends %RegisteredObject
{

ClassMethod run()
{
    Write "=== SOAP Demo (Esports) ===", !
    Do ..get_all(), ..get_one(), ..create(), ..update(), ..delete()
    Write "===========================", !
}

ClassMethod get_all()
{
    Write !,"--- get_all ---", !
    Set svc=##class(Esports.SoapService).%New()
    Set r=svc.get_all()
    Write "Count: ", r.Count(), !
    For i=1:1:r.Count() { Set p=r.GetAt(i) Write p.nick_" ("_p.country_")", ! }
}

ClassMethod get_one()
{
    Write !,"--- get_one ---", !
    Set id=$O(^Esports.PlayerD("")) Q:id=""
    Set svc=##class(Esports.SoapService).%New()
    Set r=svc.get_one(id)
    If $IsObject(r) { Write r.nick_" rating:"_r.rating, ! }
}

ClassMethod create()
{
    Write !,"--- create ---", !
    Set svc=##class(Esports.SoapService).%New()
    Set r=svc.create("soap_test"_$R(9999),"DE",6500)
    Write r, !
}

ClassMethod update()
{
    Write !,"--- update ---", !
    Set id="" Set k="" For { Set k=$O(^Esports.PlayerD(k)) Q:k="" If k["soap_test" { Set id=k Q } }
    Q:id=""
    Set svc=##class(Esports.SoapService).%New()
    Set r=svc.update(id,"FR",7000)
    Write r, !
}

ClassMethod delete()
{
    Write !,"--- delete ---", !
    Set id="" Set k="" For { Set k=$O(^Esports.PlayerD(k)) Q:k="" If k["soap_test" { Set id=k Q } }
    Q:id=""
    Set svc=##class(Esports.SoapService).%New()
    Set r=svc.delete(id)
    Write r, !
}

}
