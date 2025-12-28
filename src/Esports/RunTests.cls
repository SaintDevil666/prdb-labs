Class Esports.RunTests
{

ClassMethod Run()
{
    Write "[tests]",!
    Do ##class(Esports.Tournament).%KillExtent()
    Do ##class(Esports.Player).%KillExtent()
    Do ##class(Esports.Team).%KillExtent()
    Set ^UnitTestRoot = "/tmp/unittests"
    Set st = $System.OBJ.Export("Esports.Tests.CLS", "/tmp/unittests/Esports/Esports.Tests.xml")
    If '$$$ISOK(st) { Write "err",! Quit }
    Do ##class(%UnitTest.Manager).RunTest("Esports:Esports.Tests", "/noload/norecursive/nodelete")
    Write "done",!
}

}
