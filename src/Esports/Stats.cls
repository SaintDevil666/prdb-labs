Class Esports.Stats Extends %SerialObject
{

Property wins As %Integer;

Property losses As %Integer;

Property kd As %Decimal;

Property win_rate As %Decimal [ Calculated ];

Method win_rateGet() As %Decimal
{
    If (..wins + ..losses) = 0 Quit 0
    Quit ..wins / (..wins + ..losses)
}

}
