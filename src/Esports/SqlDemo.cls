Class Esports.SqlDemo Extends %RegisteredObject
{

ClassMethod p(t As %String)
{
    Write t, !
}

ClassMethod sep(t As %String)
{
    Write !,"--- ", t, " ---", !
}

ClassMethod dyn()
{
    Do ..sep("Dynamic SQL")
    Set q = "SELECT TOP 5 nick, rating, team->name FROM Esports.Player WHERE rating >= ? ORDER BY rating DESC"
    Set st = ##class(%SQL.Statement).%New(), sc = st.%Prepare(q)
    Set rs = st.%Execute(5000)
    While rs.%Next() { Do ..p(rs.%GetData(1)_" ("_rs.%GetData(2)_") - "_rs.%GetData(3)) }
}

ClassMethod emb()
{
    Do ..sep("Embedded SQL")
    New SQLCODE, n, r
    &sql(SELECT TOP 1 nick, rating INTO :n, :r FROM Esports.Player ORDER BY rating DESC)
    Do:(SQLCODE=0) ..p("Top: "_n_" ("_r_")")
}

ClassMethod cur()
{
    Do ..sep("Cursor")
    New SQLCODE, n, t, r
    &sql(DECLARE c1 CURSOR FOR SELECT TOP 3 nick, team->name, rating FROM Esports.Player ORDER BY rating DESC)
    &sql(OPEN c1)
    For { &sql(FETCH c1 INTO :n, :t, :r) Quit:SQLCODE'=0 Do ..p(n_" @ "_t) }
    &sql(CLOSE c1)
}

ClassMethod join()
{
    Do ..sep("Implicit Join")
    New SQLCODE, m, tt, a, b
    &sql(DECLARE c2 CURSOR FOR SELECT TOP 3 num, tournament->title, team_a->name, team_b->name FROM Esports.Match)
    &sql(OPEN c2)
    For { &sql(FETCH c2 INTO :m, :tt, :a, :b) Quit:SQLCODE'=0 Do ..p("#"_m_": "_a_" vs "_b_" @ "_tt) }
    &sql(CLOSE c2)
}

ClassMethod qry()
{
    Do ..sep("Class Query")
    Set rs = ##class(%ResultSet).%New("Esports.Player:all_players")
    Do rs.Execute()
    Set n = 0
    While rs.%Next()&&(n<3) { Set n=n+1 Do ..p(rs.%Get("nick")_" ("_rs.%Get("rating")_")") }
}

ClassMethod cos()
{
    Do ..sep("COS Query")
    Set rs = ##class(%ResultSet).%New("Esports.Tournament:by_dates")
    Do rs.Execute($H-1825, $H+365)
    Set n = 0
    While rs.%Next()&&(n<3) { Set n=n+1 Do ..p(rs.%Get("title")) }
}

ClassMethod trg()
{
    Do ..sep("Trigger")
    Kill ^esports_log
    Set p = ##class(Esports.Player).%New()
    Set p.nick = "test"_$R(9999), p.country = "UA", p.rating = 8000
    Do p.stats_populate()
    Set sc = p.%Save()
    Do:$$$ISOK(sc) ..p("Created: "_p.nick)
    Set k = "" For { Set k=$O(^esports_log("player",k)) Q:k="" Set k2="" For { Set k2=$O(^esports_log("player",k,k2)) Q:k2="" Do ..p("Log: "_k_"/"_k2_"="_$G(^esports_log("player",k,k2,$O(^esports_log("player",k,k2,""))))) } }
}

ClassMethod run()
{
    Write "========== SQL Demo (Esports) ==========", !
    Do ..emb(), ..dyn(), ..join(), ..cur(), ..cos(), ..qry(), ..trg()
    Write "========================================", !
}

}
