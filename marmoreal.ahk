; <AutoHotkey L>
; ======================================== script settings ========================================
#SingleInstance off
#NoEnv
#KeyHistory 0
ListLines Off
SetBatchLines -1

; ======================================== global vars ========================================
global VERSION := "0.0.0.1 alpha 1"
global OptionsInEffect := { "QUIET" : "", "REMOTE" : "", "LIBDIR" : "", "DEP_TO" : "", "DEP_FROM" : "", "AHK" : "", "AHK_VERSION" : "", "ENCODING" : "" }

; ======================================== libs ========================================
#Include <Remote>
#Include <Error>

#Include <CMD>
#Include <Subcommands>
#Include <CommandHandler>

#Include <OPT>
#Include <Args>
#Include <Console>

; ======================================== initialization ===========================================
Config_InitFile(), Console_Init(), Args_Process(command, subcmd, options, values)

; debugging:
;MsgBox % "command: " command "`nsubcommand: " subcmd "`noptions: " Obj_Print(options, 1) "`nvalues: " Obj_Print(values, 1)

; ======================================== read options =============================================
/*OptionsInEffect["QUIET"] := Args_HasOptions(Args, OPT.QUIET, OPT.QUIET_SHORT)
if (!OptionsInEffect["QUIET"])
	val := Config_Read("defaults", "quiet_mode"), OptionsInEffect["QUIET"] := val =	"true" || val == "1"

OptionsInEffect["REMOTE"] := Args_HasOptions(Args, OPT.QUIET, OPT.QUIET_SHORT) ? Args_GetOptionValue(Args, OPT.QUIET, OPT.QUIET_SHORT) : Remote_GetDefault()
, OptionsInEffect["LIBDIR"] := Args_HasOptions(Args, OPT.LIBDIR, OPT.LIBDIR_SHORT) ? Args_GetOptionValue(Args, OPT.QUIET, OPT.QUIET_SHORT) : Config_Read("defaults", "libdir")
, OptionsInEffect["DEP_TO"] := Args_HasOptions(Args, OPT.DEPENDENCYLIBDIR, OPT.DEPENDENCYLIBDIR_SHORT) ? Args_GetOptionValue(Args, OPT.DEPENDENCYLIBDIR, OPT.DEPENDENCYLIBDIR_SHORT) : Config_Read("defaults", "installDependencies")
, OptionsInEffect["DEP_FROM"] := Args_HasOptions(Args, OPT.DEPENDENCIES_FROM, OPT.DEPENDENCIES_FROM_SHORT) ? Args_GetOptionValue(Args, OPT.DEPENDENCIES_FROM, OPT.DEPENDENCIES_FROM_SHORT) : Config_Read("defaults", "readDependencies")
, OptionsInEffect["AHK"] := Args_HasOptions(Args, OPT.AHKVERSION, OPT.AHKVERSION_SHORT) ? Args_GetOptionValue(Args, OPT.AHKVERSION, OPT.AHKVERSION_SHORT) : Config_Read("defaults", "AHKVersion")
, OptionsInEffect["AHK_VERSION"] := Args_HasOptions(Args, OPT.AHK_REVISION, OPT.AHK_REVISION_SHORT) ? Args_GetOptionValue(Args, OPT.AHK_REVISION, OPT.AHK_REVISION_SHORT) : Config_Read("defaults", "AHKRevision")
, OptionsInEffect["ENCODING"] := Args_HasOptions(Args, OPT.ENCODING, OPT.ENCODING_SHORT) ? Args_GetOptionValue(Args, OPT.ENCODING, OPT.ENCODING_SHORT) : Config_Read("defaults", "encoding")
*/
; ======================================== validate option values ===================================
/*; quiet: doesn't need validation
Remote_ValidateName(OptionsInEffect["REMOTE"], true)
; todo: libdir
; todo: dep_to
; todo: dep_from
; todo: ahk
; todo: ahk-revision
; todo: encoding
*/

value_count := values.maxIndex()
try
{
	; ======================================== remote management ====================================
	if (command = CMD.REMOTE)
	{
		if (subcmd = Subcommands.REMOTE_ADD)
		{
			if (value_count != 2)
				throw Exception(ERROR_INVALID_PARAM_COUNT, -1, "Invalid parameter count.")
			Remote_Add(values[1], values[2])
		}
		else if (subcmd = Subcommands.REMOTE_DELETE)
		{
			if (value_count != 1)
				throw Exception(ERROR_INVALID_PARAM_COUNT, -1, "Invalid parameter count.")
			Remote_Delete(values[1])
		}
		else if (subcmd = Subcommands.REMOTE_DEFAULT)
		{
			if (value_count != 1)
				throw Exception(ERROR_INVALID_PARAM_COUNT, -1, "Invalid parameter count.")
			Remote_SetDefault(values[1])
		}
		else if (subcmd = Subcommands.REMOTE_LIST)
		{
			if (value_count > 0)
				throw Exception(ERROR_INVALID_PARAM_COUNT, -1, "Invalid parameter count.")
			remotes := Remote_List(), Console_Output("listing " remotes.maxIndex() " remotes:")
			for index, remote in remotes
				Console_Output((Remote_IsDefault(remote) ? "* " : "  ") index ": " remote)
		}
		else if (subcmd = Subcommands.REMOTE_URL)
		{
			if (value_count != 2)
				throw Exception(ERROR_INVALID_PARAM_COUNT, -1, "Invalid parameter count.")
			Remote_SetURL(values[1], values[2])
		}
	}
	; ======================================== cache management =====================================
	; todo...

	; ======================================== lib management =======================================
	; todo...

	; ======================================== app commands =========================================
	else if (command = CMD.APP)
	{
		if (subcmd = Subcommands.APP_VERSION)
		{
			if (value_count > 0)
				throw Exception(ERROR_INVALID_PARAM_COUNT, -1, "Invalid parameter count.")
			Console_Output(VERSION)
		}
		else if (subcmd = Subcommands.APP_UPDATE)
		{
			if (value_count > 0)
				throw Exception(ERROR_INVALID_PARAM_COUNT, -1, "Invalid parameter count.")
			throw Exception(ERROR_NOT_IMPLEMENTED, -1, "Action not (yet) implemented.")
		}
	}
	; ======================================== config commands ======================================
	else if (command = CMD.CONFIG)
	{
		if (subcmd = Subcommands.CONFIG_WRITE)
		{
			if (value_count != 3)
				throw Exception(ERROR_INVALID_PARAM_COUNT, -1, "Invalid parameter count.")
			Config_Write(values[1], values[2], values[3])
		}
		else if (subcmd = Subcommands.CONFIG_READ)
		{
			if (value_count != 2)
				throw Exception(ERROR_INVALID_PARAM_COUNT, -1, "Invalid parameter count.")
			Console_Output("The current value is:`n" . Config_Read(values[1], values[2]))
		}
		else if (subcmd = Subcommands.CONFIG_DELETE)
		{
			if (value_count != 2)
				throw Exception(ERROR_INVALID_PARAM_COUNT, -1, "Invalid parameter count.")
			Config_Delete(values[1], values[2])
		}
	}
	; ======================================== no valid command =====================================
	else ; change this to use some "handled" boolean or similar
	{
		throw Exception(ERROR_INVALID_PARAMETER, -1, "Invalid parameter: command was not recognized.")
	}
}
; ======================================== error handling ===========================================
catch exception
{
	m := exception.message
	if m is integer ; is assumed to be a marmoreal exception with an ERROR_XXX constant as message
	{
		Console_ErrorException(exception)
		ExitApp m
	}
	else ; invalid or builtin exceptions
	{
		Console_ErrorException(Exception(ERROR_UNKNOWN_EXCEPTION, -1, "An unknown exception occured:`n" . Console_ExceptionToString(exception, 2)))
		ExitApp ERROR_UNKNOWN_EXCEPTION
	}
}
ExitApp ERROR_SUCCESS