Console_Output(text)
{
	static out
	if (!out)
	{
		out := FileOpen(DllCall("GetStdHandle", "UInt", -11, "Ptr"), "h")
	}
	out.WriteLine(text)
	out.Read(0)
}
Console_Error(text)
{
	static err
	if (!err)
	{
		err := FileOpen(DllCall("GetStdHandle", "UInt", -12, "Ptr"), "`n")
	}
	err.WriteLine(text)
	err.Read()
}
Console_Init()
{
	DllCall("AttachConsole", "UInt", -1)
}