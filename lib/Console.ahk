/*
Function: Console_Init()
initializes marmoreal for console use
*/
Console_Init()
{
	DllCall("AttachConsole", "UInt", -1)
}

/*
Function: Console_Output()
writes text to the console stdout.

Parameters:
	text - the text to write
*/
Console_Output(text)
{
	static out
	if (!out)
	{
		out := FileOpen(DllCall("GetStdHandle", "UInt", -11, "Ptr"), "h")
	}
	out.Write(text . "`n"), out.Read(0)
}

/*
Function: Console_Error()
writes text to the console stderr

Parameters:
	text - the text to write
*/
Console_Error(text)
{
	static err
	if (!err)
	{
		err := FileOpen(DllCall("GetStdHandle", "UInt", -12, "Ptr"), "h")
	}
	err.Write(text . "`n"), err.Read(0)
}

/*
Function: Console_ErrorException()
prints the information in an exception to the console stderr.

Parameters:
	err - the exception to print
*/
Console_ErrorException(err)
{
	Console_Error("marmoreal has detected an error and will exit now.`n" . Console_ExceptionToString(err))
}

/*
Function: Console_ExceptionToString()
converts an exception object to a string suitable for prining it to stderr

Parameters:
	err - the exception to convert
	[opt] indentation - an integer indicating the indentation level (defaults to 1)

Returns:
	the string representing the exception
*/
Console_ExceptionToString(err, indentation = 0)
{
	prefix := ">"
	Loop % indentation * 2
		prefix .= A_Space
	prefix .= A_Space
	return prefix . "Message: " . err.message . "`n"
		. (err.what == -1 ? "" : (prefix . "at " . err.what . "`n"))
		. prefix . "in file """ . err.file . """`n"
		. prefix . "at line " . err.line . ".`n"
		. prefix . "Details: " . err.extra
}