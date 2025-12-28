Class Esports.RestClient Extends %RegisteredObject
{

ClassMethod run()
{
    Write "=== REST Demo (Esports) ===", !
    Do ..get_all(), ..get_one(), ..create(), ..update(), ..delete()
    Write "===========================", !
}

ClassMethod get_all()
{
    Write !,"--- GET /players ---", !
    Set req=##class(%Net.HttpRequest).%New()
    Set req.Server="localhost", req.Port=52773
    Set sc=req.Get("/esports/api/players")
    If $$$ISOK(sc)&&(req.HttpResponse.StatusCode=200) { Write req.HttpResponse.Data.Read(), ! }
    Else { Write "Err: ", req.HttpResponse.StatusCode, ! }
}

ClassMethod get_one()
{
    Write !,"--- GET /player/:id ---", !
    Set id=$O(^Esports.PlayerD("")) Q:id=""
    Set req=##class(%Net.HttpRequest).%New()
    Set req.Server="localhost", req.Port=52773
    Set sc=req.Get("/esports/api/player/"_$ZCVT(id,"O","URL"))
    If $$$ISOK(sc)&&(req.HttpResponse.StatusCode=200) { Write req.HttpResponse.Data.Read(), ! }
}

ClassMethod create()
{
    Write !,"--- POST /player ---", !
    Set req=##class(%Net.HttpRequest).%New()
    Set req.Server="localhost", req.Port=52773, req.ContentType="application/json"
    Set b={}, b.nick="test"_$R(9999), b.country="UA", b.rating=7500
    Do req.EntityBody.Write(b.%ToJSON())
    Set sc=req.Post("/esports/api/player")
    If $$$ISOK(sc) { Write req.HttpResponse.Data.Read(), ! }
}

ClassMethod update()
{
    Write !,"--- PUT /player/:id ---", !
    Set id="" Set k="" For { Set k=$O(^Esports.PlayerD(k)) Q:k="" If k["test" { Set id=k Q } }
    Q:id=""
    Set req=##class(%Net.HttpRequest).%New()
    Set req.Server="localhost", req.Port=52773, req.ContentType="application/json"
    Set b={}, b.country="PL", b.rating=8000
    Do req.EntityBody.Write(b.%ToJSON())
    Set sc=req.Put("/esports/api/player/"_$ZCVT(id,"O","URL"))
    If $$$ISOK(sc) { Write req.HttpResponse.Data.Read(), ! }
}

ClassMethod delete()
{
    Write !,"--- DELETE /player/:id ---", !
    Set id="" Set k="" For { Set k=$O(^Esports.PlayerD(k)) Q:k="" If k["test" { Set id=k Q } }
    Q:id=""
    Set req=##class(%Net.HttpRequest).%New()
    Set req.Server="localhost", req.Port=52773
    Set sc=req.Delete("/esports/api/player/"_$ZCVT(id,"O","URL"))
    If $$$ISOK(sc) { Write req.HttpResponse.Data.Read(), ! }
}

}
