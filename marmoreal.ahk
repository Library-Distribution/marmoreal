﻿; <AutoHotkey L>
#SingleInstance off
#NoEnv
#KeyHistory 0
ListLines Off
global VERSION := "0.0.0.1 alpha 1"

#Include <Remote>
#Include <Error>
#Include <CMD>
#Include <OPT>
#Include <Args>
#Include <Console>

Args := Args_Parse()
Console_Init()

; option defaults
global OptionsInEffect := { "QUIET" : false, "REMOTE" : "", "LIBDIR" : "", "DEP_TO" : "", "DEP_FROM" : "", "AHK" : "", "AHK_VERSION" : "", "ENCODING" : "" }

; read quiet mode setting
OptionsInEffect["QUIET"] := Args_HasOptions(Args, OPT.QUIET, OPT.QUIET_SHORT)
if (!OptionsInEffect["QUIET"])
	val := Config_Read("defaults", "quiet_mode"), OptionsInEffect["QUIET"] := val == "true" || val == "1"

OptionsInEffect["REMOTE"] := Args_HasOptions(Args, OPT.QUIET, OPT.QUIET_SHORT) ? Args_GetOptionValue(Args, OPT.QUIET, OPT.QUIET_SHORT) : Config_Read("defaults", "remote")

command := Args[1], value_count := Args_CountValueParams(args)

if (command = CMD_ADD_REMOTE || command = CMD_SHORT_ADD_REMOTE)
{
	if (value_count != 2)
		throw Exception("Invalid parameter count.", -1, ERROR_INVALID_PARAM_COUNT)

	Remote_Add(Args_GetValueParam(Args, 1), Args_GetValueParam(Args, 2))
}
else if (command = CMD_DELETE_REMOTE || command = CMD_SHORT_DELETE_REMOTE)
{
	if (value_count != 1)
		throw Exception("Invalid parameter count.", -1, ERROR_INVALID_PARAM_COUNT)

	Remote_Delete(Args_GetValueParam(Args, 1))
}
else if (command = CMD_SET_DEFAULT_REMOTE || command = CMD_SHORT_SET_DEFAULT_REMOTE)
{
	if (value_count != 1)
		throw Exception("Invalid parameter count.", -1, ERROR_INVALID_PARAM_COUNT)

	Remote_SetDefault(Args_GetValueParam(Args, 1))
}
else if (command = CMD_LIST_REMOTE || command = CMD_SHORT_LIST_REMOTE)
{
	if (value_count > 0)
		throw Exception("Invalid parameter count.", -1, ERROR_INVALID_PARAM_COUNT)

	remotes := Remote_List(), Console_Output("listing " remotes.maxIndex() " remotes:")
	for index, remote in remotes
		Console_Output((Remote_IsDefault(remote) ? "* " : "  ") index ": " remote)
}

else if (command = CMD_VERSION || command = CMD_SHORT_VERSION)
{
	if (value_count > 0)
		throw Exception("Invalid parameter count.", -1, ERROR_INVALID_PARAM_COUNT)

	Console_Output(VERSION)
}
else if (command = CMD_CONFIG || command = CMD_SHORT_CONFIG)
{
	if (value_count == 3)
		Config_Write(Args_GetValueParam(Args, 1), Args_GetValueParam(Args, 2), Args_GetValueParam(Args, 3))
	else if (value_count == 2)
		Console_Output("The current value is: """ . Config_Read(Args_GetValueParam(Args, 1), Args_GetValueParam(Args, 2)) . """.")
	else
		throw Exception("Invalid parameter count.", -1, ERROR_INVALID_PARAM_COUNT)
}
else
{
	throw Exception("Invalid parameter: command was not recognized.", -1, ERROR_INVALID_PARAMETER)
}
ExitApp ERROR_SUCCESS