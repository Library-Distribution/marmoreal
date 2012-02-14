/*
Function: Args_Parse()
parses the command line parameters into an array and returns it
*/
Args_Parse()
{
	local args := []
	Loop %0%
	{
		args[A_Index] := Trim(%A_Index%, " `t""'")
	}
	return args
}

/*
Function: Args_HasOption()
checks if the command line includes the specified option

Paramters:
	args - the argument array as returned by <Args_Parse()>
	option - an option string to find, typically a field from the OPT class

Returns:
	true if found, false otherwise
*/
Args_HasOption(args, option)
{
	return Args_FindOption(args, option) > 0
}

/*
Function: Args_HasOptions()
checks if the command line includes any of the specified options

Parameters:
	args - the argument array as returned by <Args_Parse()>
	options* - a variadic list of options to check for

Returns:
	true if any of the options was found, false if none was found
*/
Args_HasOptions(args, options*)
{
	for each, option in options
		if Args_HasOption(args, option)
			return true
	return false
}

/*
Function: Args_HasAllOptions
checks if the command line includes all of the specified options

Parameters:
	args - the argument array as returned by <Args_Parse()>
	options* - a variadic list of options to check for

Returns:
	true if all of the options was found, false if one ore more were not found
*/
Args_HasAllOptions(args, options*)
{
	bool := false
	for each, option in options
		bool := bool && Args_HasOption(args, option)
	return bool
}

/*
Function: Args_FindOption()
finds a specified option

Parameters:
	args - the argument array as returned by <Args_Parse()>
	option - the option string to search for

Returns:
	the index of the option in the argument array or -1 if not found
*/
Args_FindOption(args, option)
{
	Loop
	{
		index := Args_FindValue(args, option)
	} Until (index == -1 || Args_IsOption(args, index))
	return index
}

/*
Function: Args_IsOption()
[for internal use] checks if the specified argument is an option argument or not

Parameters:
	args - the argument array as returned by <Args_Parse()>
	index - the index of the argument within the array

Returns:
	true if it is an option, false otherwise
*/
Args_IsOption(args, index)
{
	return Args_FindValue(OPT, args[index]) > -1 && Args_FindValue(args, "--") < index
}

/*
Function: Args_IsOptionValue()
[for internal use] checks if a specified argument is the value for an option or not

Parameters:
	args - the argument array as returned by <Args_Parse()>
	index - the index of the argument within the array

Returns:
	true if it is a value for an option, false otherwise
*/
Args_IsOptionValue(args, index)
{
	return Args_IsOption(args, index - 1) && Args_FindValue(OPT_HANDLER.ValueOptions, args[index - 1]) > -1
}

/*
Function: Args_GetOptionValue()
gets the value of a option which has a parameter

Parameters:
	args - the argument array as returned by <Args_Parse()>
	options* - a variadic list of options to check for

Returns:
	the value of the first occurence of one of the specified options
*/
Args_GetOptionValue(args, options*)
{
	for each, option in options
	{
		index := Args_FindOption(args, option)
		if (index > 0)
			return args[index+1]
	}
}

/*
Function: Args_HasOnlyOneOption()
checks if one and only one of the specified options is present

Parameters:
	args - the argument array as returned by <Args_Parse()>
	options* - a variadic list of options to check for

Returns:
	false if 0 or > 1 occurrences of any of the options were found, true if there's just 1
*/
Args_HasOnlyOneOption(args, options*)
{
	found := false, temp_found := false
	for each, option in options
	{
		temp_found := Args_HasOption(args, option)
		if (found)
			return false
		found := temp_found
	}
	return found
}

; ===========================================================================================================
/*
Function: Args_GetValueParam()
gets the value of a parameter which is *not an option*

Parameters:
	args - the argument array as returned by <Args_Parse()>
	index - the index of the value parameter ("search for the %index%st value param")

Returns:
	the value of that parameter
*/
Args_GetValueParam(args, index)
{
	return args[Args_FindValueParam(args, index)]
}

/*
Function: Args_CountValueParams()
counts the number of parameters that are not options

Parameters:
	args - the argument array as returned by <Args_Parse()>

Returns:
	the count (0 if none were specified)
*/
Args_CountValueParams(args)
{
	count := 0
	while (Args_FindValueParam(args, A_Index) > -1)
		count++
	return count
}

/*
Function: Args_FindValueParam()
[for internal use] finds a parameter which is not an option

Parameters:
	args - the argument array as returned by <Args_Parse()>
	index - the index of the value parameter ("search for the %index%st value param")

Returns:
	the index of the parameter, if found. -1 if none is found.
*/
Args_FindValueParam(args, index)
{
	foundIndex := 0
	for each, arg in args
	{
		if (A_Index == 1 || A_Index < index)
			continue
		if (!Args_IsOption(args, A_Index) && !Args_IsOptionValue(args, A_Index) && arg != "--")
			foundIndex++
		if (foundIndex == index)
			return A_Index
	}
	return -1
}

; ===========================================================================================================
/*
Function: Args_FindValue
[for internal use] finds a value in the argument array

Parameters:
	args - the argument array as returned by <Args_Parse()>
	value - the value to find

Returns:
	the index if found, -1 otherwise
*/
Args_FindValue(args, value)
{
	for each, arg in args
		if (arg == value)
			return A_Index
	return -1
}