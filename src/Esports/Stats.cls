Class Esports.Stats Extends %SerialObject
{

Property wins As %Integer(POPSPEC = "Integer(0,500)");

Property losses As %Integer(POPSPEC = "Integer(0,300)");

Property kd As %Float(POPSPEC = "Float(0.5,2.0)");

Method total() As %Integer
{
    Quit ..wins + ..losses
}

}
