Class Esports.PlayerPage Extends %CSP.Page
{

Parameter CONTENTTYPE = "text/html";

ClassMethod OnPage() As %Status
{
    Set act=%request.Get("a"), id=%request.Get("id")
    &html<<!DOCTYPE html><html><head><title>Esports - Players</title>
    <style>
    body{font-family:Arial;margin:20px;background:#f0f8ff}
    h1,h2{color:#2980b9}
    table{border-collapse:collapse;width:100%;margin:20px 0}
    th,td{border:1px solid #3498db;padding:8px;text-align:left}
    th{background:#3498db;color:#fff}
    tr:hover{background:#d6eaf8}
    .btn{padding:6px 12px;margin:3px;cursor:pointer;border:none;border-radius:3px}
    .btn-p{background:#3498db;color:#fff}
    .btn-d{background:#e74c3c;color:#fff}
    .btn-s{background:#7f8c8d;color:#fff}
    input,select{padding:6px;margin:3px 0;width:250px}
    .fg{margin:10px 0}
    label{display:block;margin-bottom:3px;color:#2980b9}
    .msg{padding:8px;margin:8px 0;border-radius:3px}
    .ok{background:#d4edda;color:#155724}
    .err{background:#f8d7da;color:#721c24}
    a{color:#3498db}
    </style></head><body>>
    If act="edit" { Do ..edit(id) }
    ElseIf act="new" { Do ..new() }
    ElseIf act="save" { Do ..save() }
    ElseIf act="del" { Do ..del(id) }
    ElseIf act="view" { Do ..view(id) }
    Else { Do ..list() }
    &html<</body></html>>
    Q $$$OK
}

ClassMethod list()
{
    &html<<h1>Players</h1><a href="?a=new"><button class="btn btn-p">Add</button></a>
    <table><tr><th>ID</th><th>Nick</th><th>Country</th><th>Rating</th><th>Actions</th></tr>>
    Set k="" For { Set k=$O(^Esports.PlayerD(k)) Q:k=""
        Set d=$G(^Esports.PlayerD(k)), n=$LG(d,2), c=$LG(d,3), r=$LG(d,4)
        &html<<tr><td>#(k)#</td><td>#($ZCVT(n,"O","HTML"))#</td><td>#($ZCVT(c,"O","HTML"))#</td><td>#(r)#</td>
        <td><a href="?a=view&id=#($ZCVT(k,"O","URL"))#"><button class="btn btn-s">View</button></a>
        <a href="?a=edit&id=#($ZCVT(k,"O","URL"))#"><button class="btn btn-p">Edit</button></a>
        <a href="?a=del&id=#($ZCVT(k,"O","URL"))#" onclick="return confirm('Delete?')"><button class="btn btn-d">Del</button></a></td></tr>>
    }
    &html<</table>>
}

ClassMethod view(id)
{
    &html<<h1>Player Details</h1><a href="?"><button class="btn btn-s">Back</button></a>>
    Set p=##class(Esports.Player).%OpenId(id) If '$IsObject(p) { &html<<div class="msg err">Not found</div>> Q }
    &html<<div class="fg"><label>ID:</label>#($ZCVT(id,"O","HTML"))#</div>
    <div class="fg"><label>Nick:</label>#($ZCVT(p.nick,"O","HTML"))#</div>
    <div class="fg"><label>Country:</label>#($ZCVT(p.country,"O","HTML"))#</div>
    <div class="fg"><label>Rating:</label>#(p.rating)#</div>
    <div class="fg"><label>Win Rate:</label>#(p.win_rate)#%</div>>
}

ClassMethod new()
{
    &html<<h1>New Player</h1><a href="?"><button class="btn btn-s">Back</button></a>
    <form method="post" action="?a=save">
    <div class="fg"><label>Nick:</label><input type="text" name="nick" required></div>
    <div class="fg"><label>Country:</label><input type="text" name="country"></div>
    <div class="fg"><label>Rating:</label><input type="number" name="rating" min="0" max="10000"></div>
    <button type="submit" class="btn btn-p">Save</button></form>>
}

ClassMethod edit(id)
{
    Set p=##class(Esports.Player).%OpenId(id) If '$IsObject(p) { &html<<div class="msg err">Not found</div>> Q }
    &html<<h1>Edit Player</h1><a href="?"><button class="btn btn-s">Back</button></a>
    <form method="post" action="?a=save"><input type="hidden" name="oid" value="#($ZCVT(id,"O","HTML"))#">
    <div class="fg"><label>Nick:</label><input type="text" name="nick" value="#($ZCVT(p.nick,"O","HTML"))#" required></div>
    <div class="fg"><label>Country:</label><input type="text" name="country" value="#($ZCVT(p.country,"O","HTML"))#"></div>
    <div class="fg"><label>Rating:</label><input type="number" name="rating" value="#(p.rating)#" min="0" max="10000"></div>
    <button type="submit" class="btn btn-p">Save</button></form>>
}

ClassMethod save()
{
    Set n=%request.Get("nick"), c=%request.Get("country"), r=%request.Get("rating"), oid=%request.Get("oid")
    If oid'="" { Set p=##class(Esports.Player).%OpenId(oid) If '$IsObject(p) { &html<<div class="msg err">Not found</div>> Q } }
    Else { Set p=##class(Esports.Player).%New() }
    Set p.nick=n, p.country=c, p.rating=r
    If '$IsObject(p.stats) { Set p.stats=##class(Esports.Stats).%New() Set p.stats.wins=0,p.stats.losses=0,p.stats.kd=1 }
    Set sc=p.%Save()
    If $$$ISOK(sc) { &html<<div class="msg ok">Saved</div>> }
    Else { &html<<div class="msg err">#($System.Status.GetErrorText(sc))#</div>> }
    Do ..list()
}

ClassMethod del(id)
{
    Set sc=##class(Esports.Player).%DeleteId(id)
    If $$$ISOK(sc) { &html<<div class="msg ok">Deleted</div>> }
    Else { &html<<div class="msg err">#($System.Status.GetErrorText(sc))#</div>> }
    Do ..list()
}

}
