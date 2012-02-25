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
	static CMD_REMOTE := "remote"
	static CMD_REMOTE_ADD := "add"
	static CMD_REMOTE_DELETE := "delete"
	static CMD_REMOTE_DEFAULT := "set-default"
	static CMD_REMOTE_URL := "set-url"
	static CMD_REMOTE_LIST := "list"

	static CMD_CACHE := "cache"
	static CMD_CACHE_CLEAR := "clear"
	static CMD_CACHE_ADD := "add"
	static CMD_CACHE_REMOVE := "remove"

	static CMD_CONFIG := "config"
	static CMD_CONFIG_WRITE := "write"
	static CMD_CONFIG_READ := "read"
	static CMD_CONFIG_DELETE := "delete"

	static CMD_APP := "app"
	static CMD_APP_UPDATE := "update"

	static CMD_GUI := "gui"

	static CMD_INSTALL := "install"
	static CMD_REMOVE := "remove"
	static CMD_UPDATE := "update"

	static Mapping := { CMD.CMD_REMOTE		: [CMD.CMD_REMOTE_ADD, CMD.CMD_REMOTE_DELETE, CMD.CMD_REMOTE_DEFAULT, CMD.CMD_REMOTE_URL, CMD.CMD_REMOTE_LIST]
						, CMD.CMD_CONFIG	: [CMD.CMD_CONFIG_DELETE, CMD.CMD_CONFIG_READ, CMD.CMD_CONFIG_WRITE]
						, CMD.CMD_CACHE		: [CMD.CMD_CACHE_CLEAR, CMD.CMD_CACHE_ADD, CMD.CMD_CACHE_REMOVE]
						, CMD.CMD_APP		: [CMD.CMD_APP_UPDATE]
						, CMD.CMD_GUI		: ""
						, CMD.CMD_INSTALL	: ""
						, CMD.CMD_REMOVE	: ""
						, CMD.CMD_UPDATE	: "" }
}