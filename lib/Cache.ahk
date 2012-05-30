class Cache
{
	/*
	static
	*/

	GetCache(remote)
	{
		if (!Cache.cacheList[remote])
		{
			Cache.cacheList[remote] := new Cache(remote)
		}
		return Cache.cacheList[remote]
	}

	ReleaseCache(remote)
	{
		Cache.cacheList[remote] := ""
	}

	static cacheList := {}

	EncodeRemote(remote)
	{
		return RegExReplace(remote, "\/\\:\*\?""<>\|", "_")
	}

	/*
	static and instance
	*/

	Ensure()
	{
		if (this == Cache)
		{
			if (!FileExist(A_ScriptDir . "\Cache"))
			{
				FileCreateDir %A_ScriptDir%\Cache
			}
		}
		else
		{
			Cache.Ensure()
			if (!FileExist(A_ScriptDir . "\Cache\" . this.EncodedRemote))
			{
				FileCreateDir % A_ScriptDir . "\Cache\" . this.EncodedRemote
			}
			this.EnsureData()
		}
	}

	Clear()
	{
		if (this == Cache)
		{
			FileRemoveDir %A_ScriptDir%\Cache, 1
		}
		else
		{
			FileRemoveDir % A_ScriptDir . "\Cache\" . this.EncodedRemote, 1
		}
		this.Ensure()
	}

	/*
	instance
	*/

	Remote := ""
	EncodedRemote := ""

	Database := ""

	__New(remote)
	{
		this.Remote := remote
		, EncodedRemote := Cache.EncodeRemote(remote)
		, this.Ensure()
		, this.Database:= DBA.DataBaseFactory.OpenDataBase("SQLite", A_ScriptDir . "\Cache\" . this.EncodedRemote . "\data.sqlite")
		, this.EnsureData()
	}

	EnsureData()
	{
		if (IsObject(this.Database))
		{
			this.Database.Query("CREATE TABLE IF NOT EXISTS data (id, name, type, version, user, description, uploaded, downloaded, tags, default, PRIMARY KEY (id));")
		}
	}

	Add(data, package)
	{
		this.Ensure()
		FileCopy %package%, % A_ScriptDir . "\Cache\" . this.EncodedRemote . "\" . data["id"], 1
		this.Database.BeginTransaction()
		this.Database.Query("INSERT INTO data (id, name, type, version, user, description, uploaded, downloaded, tags, default)`n"
						. " VALUES`n(" . data["id"]
									. ", " . data["name"]
									. ", " . data["type"]
									. ", " . data["version"]
									. ", " . data["user"]
									. ", " . data["description"]
									. ", " . data["uploaded"]
									. ", " . data["downloaded"]
									. ", " . data["tags"]
									. ", " . data["default"]
						. ");")
		this.Database.endTransaction()
	}

	Remove(id)
	{
		if (FileExist(A_ScriptDir . "\Cache\" . this.EncodedRemote))
		{
			FileDelete % A_ScriptDir . "\Cache\" . this.EncodedRemote . "\" . id
		}
		; write database
	}

	IsCached(id)
	{
		return FileExist(A_ScriptDir . "\Cache\" . this.EncodedRemote . "\" . id)
	}

	GetDataById(id)
	{
		return this.Database.Query("SELECT * FROM data WHERE id = '" . id . "'")
	}

	GetData(name, version)
	{
		return this.Database.Query("SELECT * FROM data WHERE name = '" . name . "' AND version = '" . version . "'")
	}
}
