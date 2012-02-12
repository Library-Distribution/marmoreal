; <AutoHotkey L>
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
	Remote_Add(Args[2], Args[3])
}
else if (command = CMD_DELETE_REMOTE || command = CMD_SHORT_DELETE_REMOTE)
{
	Remote_Delete(Args[2])
}
else if (command = CMD_SET_DEFAULT_REMOTE || command = CMD_SHORT_SET_DEFAULT_REMOTE)
{
	Remote_SetDefault(Args[2])
}
if (command = CMD_VERSION || command = CMD_SHORT_VERSION)
{
	Console_Output(VERSION)
}
Exit(ERROR_SUCCESS)