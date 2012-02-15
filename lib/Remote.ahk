Remote_Add(name, url)
{
	Remote_ValidateName(name, true)
	, Remote_ValidateURL(url)
	, Config_Write("remotes", name, url)
}
Remote_Delete(name)
{
	Remote_ValidateName(name, true)
	, Config_Delete("remotes", name)
}
Remote_SetDefault(name)
{
	Remote_ValidateName(name, true)
	if (!Remote_Exists(name))
		throw Exception(ERROR_INVALID_PARAMETER, -1, "Invalid parameter: 'name' must be a valid and existing remote name.")
	Config_Write("defaults", "remote", name)
}
Remote_Exists(name)
{
	return Config_KeyExists("remotes", name)
}
Remote_GetDefault()
{
	return Config_Read("defaults", "remote")
}
Remote_GetURL(name)
{
	Remote_ValidateName(name, true)
	return Config_Read("remotes", name)
}
Remote_IsDefault(name)
{
	return Remote_GetDefault() = name
}

Remote_ValidateName(name, throwOnError = false)
{
	result := RegExMatch(name, "^\w+$")
	if (!result && throwOnError)
		throw Exception(ERROR_INVALID_PARAMETER, -1, "Invalid parameter: 'name' must consist of letters, digits and underscores.")
	return result
}
Remote_List()
{
	return Config_ListKeys("remotes")
}
Remote_ValidateURL(url, throwOnError = false)
{
	; TODO
	if (invalid && throwOnError)
		throw Exception(ERROR_INVALID_PARAMETER, -1, "Invalid parameter: 'url' must be a valid URL.")
	return true
}