Ping(site)
{
	For objStatus in ComObjGet("winmgmts:").ExecQuery("Select * From Win32_PingStatus where Address = '" site "'")
	{
		return objStatus.StatusCode == 0
	}
	return false
}