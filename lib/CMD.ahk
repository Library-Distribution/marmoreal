/*
	old, deprecated command organization
*/
global CMD_ADD_REMOTE := "add-remote", CMD_SHORT_ADD_REMOTE := "ar"
global CMD_DELETE_REMOTE := "delete-remote", CMD_SHORT_DELETE_REMOTE := "dr"
global CMD_SET_DEFAULT_REMOTE := "set-default-remote", CMD_SHORT_SET_DEFAULT_REMOTE := "sdr"
global CMD_LIST_REMOTE := "list-remotes", CMD_SHORT_LIST_REMOTE := "lr"

global CMD_INSTALL_LIB := "install", CMD_SHORT_INSTALL_LIB := "il"
global CMD_REMOVE_LIB := "remove", CMD_SHORT_REMOVE_LIB := "rl"
global CMD_UPDATE_LIB := "update", CMD_SHORT_UPDATE_LIB := "ul"

global CMD_UPDATE_APP := "update-app", CMD_SHORT_UPDATE_APP := "ua"
global CMD_CLEAR_CACHE := "clear-cache", CMD_SHORT_CLEAR_CACHE := "cc"
global CMD_VERSION := "version", CMD_SHORT_VERSION := "v"
global CMD_GUI := "user-interface", CMD_SHORT_GUI := "gui"
global CMD_CONFIG := "config", CMD_SHORT_CONFIG := "cg"

/*
	new command organization
*/
class CMD
{
	static REMOTE := "remote"
	static CACHE := "cache"
	static CONFIG := "config"
	static APP := "app"
	static GUI := "gui"
	static INSTALL := "install"
}

class Subcommands
{
	static REMOTE_ADD := "add"
	static REMOTE_DELETE := "delete"
	static REMOTE_DEFAULT := "set-default"
	static REMOTE_URL := "set-url"
	static REMOTE_LIST := "list"

	static CACHE_CLEAR := "clear"
	static CACHE_ADD := "add"
	static CACHE_REMOVE := "remove"

	static CONFIG_WRITE := "write"
	static CONFIG_READ := "read"
	static CONFIG_DELETE := "delete"

	static APP_UPDATE := "update"

	static REMOVE := "remove"
	static UPDATE := "update"
}

class CommandHandler
{
	static Mapping := { CMD.REMOTE		: [Subcommands.REMOTE_ADD,		Subcommands.REMOTE_DELETE,	Subcommands.REMOTE_DEFAULT,	Subcommands.REMOTE_URL,	Subcommands.REMOTE_LIST]
						, CMD.CONFIG	: [Subcommands.CONFIG_DELETE,	Subcommands.CONFIG_READ,	Subcommands.CONFIG_WRITE]
						, CMD.CACHE		: [Subcommands.CACHE_CLEAR,		Subcommands.CACHE_ADD,		Subcommands.CACHE_REMOVE]
						, CMD.APP		: [Subcommands.APP_UPDATE]
						, CMD.GUI		: ""
						, CMD.INSTALL	: ""
						, CMD.REMOVE	: ""
						, CMD.UPDATE	: "" }

	IsValidCommand(str)
	{
		return Obj_FindValue(CMD, str) != ""
	}

	IsValidSubcommand(command, str)
	{
		return Obj_FindValue(CommandHandler.Mapping[command], str) != ""
	}
}