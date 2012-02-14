﻿; <AutoHotkey L>
#SingleInstance off
#NoEnv
#KeyHistory 0
ListLines Off

#Include <Remote>
#Include <Error>
#Include <Exit>
#Include <CMD>
#Include <OPT>
#Include <Args>
#Include <Console>

global VERSION := "0.0.0.1 alpha 1"

Args := Args_Parse()
Console_Init()

command := Args[1]
if (command = CMD_ADD_REMOTE || command = CMD_SHORT_ADD_REMOTE)
{
	Remote_Add(Args_GetValueParam(Args, 1), Args_GetValueParam(Args, 2))
}
else if (command = CMD_DELETE_REMOTE || command = CMD_SHORT_DELETE_REMOTE)
{
	Remote_Delete(Args_GetValueParam(Args, 1))
}
else if (command = CMD_SET_DEFAULT_REMOTE || command = CMD_SHORT_SET_DEFAULT_REMOTE)
{
	Remote_SetDefault(Args_GetValueParam(Args, 1))
}
else if (command = CMD_LIST_REMOTE || command = CMD_SHORT_LIST_REMOTE)
{
	remotes := Remote_List()
	Console_Output("listing " remotes.maxIndex() " remotes:")
	for index, remote in remotes
		Console_Output((Remote_IsDefault(remote) ? "* " : "  ") index ": " remote)
	Console_Output("")
}

else if (command = CMD_VERSION || command = CMD_SHORT_VERSION)
{
	Console_Output(VERSION)
}
else if (command = CMD_CONFIG || command = CMD_SHORT_CONFIG)
{
	Config_Write(Args_GetValueParam(Args, 1),Args_GetValueParam(Args, 2), Args_GetValueParam(Args, 3))
}
Exit(ERROR_SUCCESS)