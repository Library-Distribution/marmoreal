class CommandHandler
{
	static Mapping := { CMD.REMOTE		: [Subcommands.REMOTE_ADD,		Subcommands.REMOTE_DELETE,	Subcommands.REMOTE_DEFAULT,	Subcommands.REMOTE_URL,	Subcommands.REMOTE_LIST]
						, CMD.CONFIG	: [Subcommands.CONFIG_DELETE,	Subcommands.CONFIG_READ,	Subcommands.CONFIG_WRITE]
						, CMD.CACHE		: [Subcommands.CACHE_CLEAR,		Subcommands.CACHE_ADD,		Subcommands.CACHE_REMOVE]
						, CMD.APP		: [Subcommands.APP_UPDATE,		Subcommands.APP_VERSION]
						, CMD.GUI		: ""
						, CMD.INSTALL	: ""
						, CMD.REMOVE	: "" }

	IsValidCommand(str)
	{
		return Obj_FindValue(CMD, str) != ""
	}

	IsValidSubcommand(command, str)
	{
		return Obj_FindValue(CommandHandler.Mapping[command], str) != ""
	}
}