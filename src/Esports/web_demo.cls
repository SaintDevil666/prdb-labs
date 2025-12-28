Class Esports.WebDemo Extends %RegisteredObject
{

ClassMethod run()
{
    Write "=== Web Demo (Esports PR7) ===", !
    Write !, "REST:", ! Do ##class(Esports.RestClient).run()
    Write !, "SOAP:", ! Do ##class(Esports.SoapClient).run()
    Write !, "URLs:", !
    Write "CSP: http://localhost:52773/csp/user/Esports.PlayerPage.cls", !
    Write "REST: http://localhost:52773/esports/api/players", !
    Write "WSDL: http://localhost:52773/csp/user/Esports.SoapService.cls?WSDL", !
}

ClassMethod setup()
{
    Write "Setup:", !
    Write "1. REST app: /esports/api -> Esports.RestBroker", !
    Write "2. CSP auto at /csp/user/", !
}

}
