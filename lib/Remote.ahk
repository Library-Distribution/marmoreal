Remote_Add(name, url)
{
	if (!Remote_ValidateName(name))
		throw Exception("Invalid parameter: 'name' must consist of letters, digits and underscores.", -1, ERROR_INVALID_PARAMETER)
	if (!Remote_ValidateURL(url))
		throw Exception("Invalid parameter: 'url' must be a valid URL.", -1, ERROR_INVALID_PARAMETER)
	IniWrite %url%, %A_ScriptDir%\marmoreal-config.ini, Remotes, %name%
	if (ErrorLevel)
		throw Exception("No write access: could not write to config file.", -1, ERROR_NO_CONFIG_WRITE_ACCESS)
}
Remote_Delete(name)
{
	if (!Remote_ValidateName(name))
		throw Exception("Invalid parameter: 'name' must consist of letters, digits and underscores.", -1, ERROR_INVALID_PARAMETER)
	IniDelete %A_ScriptDir%\marmoreal-config.ini, Remotes, %name%
	if (ErrorLevel)
		throw Exception("No write access: could not write to config file.", -1, ERROR_NO_CONFIG_WRITE_ACCESS)
}
Remote_SetDefault(name)
{
	if (!Remote_ValidateName(name))
		throw Exception("Invalid parameter: 'name' must consist of letters, digits and underscores.", -1, ERROR_INVALID_PARAMETER)
	IniWrite %name%, %A_ScriptDir%\marmoreal-config.ini, Defaults, remote
	if (ErrorLevel)
		throw Exception("No write access: could not write to config file.", -1, ERROR_NO_CONFIG_WRITE_ACCESS)
}
Remote_GetDefault()
{
	if (!Remote_ValidateName(name))
		throw Exception("Invalid parameter: 'name' must consist of letters, digits and underscores.", -1, ERROR_INVALID_PARAMETER)
	IniRead name, %A_ScriptDir%\marmoreal-config.ini, Defaults, remote, %A_Space%
	if (ErrorLevel)
		throw Exception("No read access: could not read from config file.", -1, ERROR_NO_CONFIG_READ_ACCESS)
	return name
}
Remote_GetURL(name)
{
	if (!Remote_ValidateName(name))
		throw Exception("Invalid parameter: 'name' must consist of letters, digits and underscores.", -1, ERROR_INVALID_PARAMETER)
	IniRead url, %A_ScriptDir%\marmoreal-config.ini, Remotes, %name%
	return url
}

Remote_ValidateName(name)
{
	return RegExMatch(name, "^\w+$")
}
Remote_ValidateURL(url)
{
	; TODO
	return true
}