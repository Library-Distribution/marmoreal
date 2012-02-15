Config_Write(section, key, value)
{
	IniWrite %value%, %A_ScriptDir%\marmoreal-config.ini, %section%, %key%
	if (ErrorLevel)
		throw Exception(ERROR_NO_CONFIG_WRITE_ACCESS, -1, "No write access: could not write to config file.")
}
Config_Read(section, key)
{
	IniRead value, %A_ScriptDir%\marmoreal-config.ini, %section%, %key%, %A_Space%
	if (ErrorLevel)
		throw Exception(ERROR_NO_CONFIG_READ_ACCESS, -1, "No read access: could not read from config file.")
	return value
}
Config_Delete(section, key)
{
	IniDelete %A_ScriptDir%\marmoreal-config.ini, %section%, %key%
	if (ErrorLevel)
		throw Exception(ERROR_NO_CONFIG_WRITE_ACCESS, -1, "No write access: could not write to config file.")
}
Config_KeyExists(section, key)
{
	IniRead alldata, %A_ScriptDir%\marmoreal-config.ini, %section%
	return RegExMatch(alldata, "(^|\n)\s*\Q" key "\E\s*=.*") > 0
}
Config_SectionExists(section)
{
	IniRead sections, %A_ScriptDir%\marmoreal-config.ini
	return RegExMatch(sections, "(^|\n)\Q" section "\E(\n|$)") > 0
}
Config_ListSections()
{
	IniRead raw, %A_ScriptDir%\marmoreal-config.ini
	sections := []
	StringSplit raw, raw, `n, `r
	Loop %raw0%
		sections[A_Index] := raw%A_Index%
	return sections
}
Config_ListKeys(section)
{
	IniRead raw, %A_ScriptDir%\marmoreal-config.ini, %section%
	keys := []
	StringSplit raw, raw, `n, `r
	Loop %raw0%
	{
		RegExMatch(raw%A_Index%, "mU)^\s*(?P<key>.*)\s*=", data)
		keys[A_Index] := datakey
	}
	return keys
}
Config_InitFile()
{
	; TODO: create default file if not present
}
Config_ValidateSection(section, throwOnError = false)
{
	; TODO
	return true
}
Config_ValidateKey(key, throwOnError = false)
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