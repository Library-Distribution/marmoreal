class CMD
{
	static REMOTE := "remote"
	static CACHE := "cache"
	static CONFIG := "config"
	static APP := "app"
	static GUI := "gui"
	static INSTALL := "install"
	static REMOVE := "remove"
	static UPDATE := "update"
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
	static APP_VERSION := "version"
}

class CommandHandler
{
	static Mapping := { CMD.REMOTE		: [Subcommands.REMOTE_ADD,		Subcommands.REMOTE_DELETE,	Subcommands.REMOTE_DEFAULT,	Subcommands.REMOTE_URL,	Subcommands.REMOTE_LIST]
						, CMD.CONFIG	: [Subcommands.CONFIG_DELETE,	Subcommands.CONFIG_READ,	Subcommands.CONFIG_WRITE]
						, CMD.CACHE		: [Subcommands.CACHE_CLEAR,		Subcommands.CACHE_ADD,		Subcommands.CACHE_REMOVE]
						, CMD.APP		: [Subcommands.APP_UPDATE,		Subcommands.APP_VERSION]
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