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