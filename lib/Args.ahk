Args_Parse()
{
	local args := []
	Loop %0%
	{
		args[A_Index] := Trim(%A_Index%, " `t""'")
	}
	return args
}
Args_HasOption(args, option)
{
	return Args_FindValue(args, option) > 0
}
Args_HasOptions(args, options*)
{
	bool := false
	for each, option in options
		bool := bool || Args_HasOption(args, option)
	return bool
}
Args_HasAllOptions(args, options*)
{
	bool := false
	for each, option in options
		bool := bool && Args_HasOption(args, option)
	return bool
}
Args_FindValueParam(args, index)
{
	foundIndex := 0
	for each, arg in args
	{
		if (A_Index == 1 || A_Index < index)
			continue
		if (!Args_IsOption(arg))
			foundIndex++
		if (foundIndex == index)
			return A_Index
	}
}
Args_GetValueParam(args, index)
{
	return args[Args_FindValueParam(args, index)]
}
Args_IsOption(arg)
{
	return SubStr(arg, 1, 2) == "--"
}
Args_IsQuietMode(args)
{
	return Args_HasOptions(args, OPT_QUIET_MODE, OPT_SHORT_QUIET_MODE)
}
Args_FindValue(args, value)
{
	for each, arg in args
		if (arg == value)
			return A_Index
	return 0
}