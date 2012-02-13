Config_Write(section, key, value)
{
	IniWrite %value%, %A_ScriptDir%\marmoreal-config.ini, %section%, %key%
	if (ErrorLevel)
		throw Exception("No write access: could not write to config file.", -1, ERROR_NO_CONFIG_WRITE_ACCESS)
}
Config_Read(section, key)
{
	IniRead value, %A_ScriptDir%\marmoreal-config.ini, %section%, %key%, %A_Space%
	if (ErrorLevel)
		throw Exception("No read access: could not read from config file.", -1, ERROR_NO_CONFIG_READ_ACCESS)
	return value
}
Config_Delete(section, key)
{
	IniDelete %A_ScriptDir%\marmoreal-config.ini, %section%, %key%
	if (ErrorLevel)
		throw Exception("No write access: could not write to config file.", -1, ERROR_NO_CONFIG_WRITE_ACCESS)
}
Config_KeyExists(section, key)
{
	IniRead dummy, %A_ScriptDir%\marmoreal-config.ini, %section%, %key%, ~~~
	return !(dummy == "~~~")
}
Config_InitFile()
{
	; TODO: create default file if not present
}
Config_ValidateSection(section)
{
	; TODO
	return true
}
Config_ValidateKey(key)
{
	; TODO
	return true
}
Config_EscapeValue(value)
{
	; TODO
	return value
}
Config_UnescapeValue(value)
{
	; TODO
	return value
}