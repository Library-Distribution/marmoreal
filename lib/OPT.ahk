class OPT
{
	static QUIET := "--quiet"
	static QUIET_SHORT := "-q"

	static REMOTE := "--remote"
	static REMOTE_SHORT := "-r"

	static LIBDIR := "--libdir"
	static LIBDIR_SHORT := "-l"

	static DEPENDENCYLIBDIR := "--dependencies-to"
	static DEPENDENCYLIBDIR_SHORT := "-dt"

	static DEPENDENCIES_FROM := "--dependencies-from"
	static DEPENDENCIES_FROM_SHORT := "-df"

	static AHKVERSION := "--ahkversion"
	static AHKVERSION_SHORT := "-a"

	static AHK_REVISION := "--ahk-revision"
	static AHK_REVISION_SHORT := "-ar"

	static ENCODING := "--encoding"
	static ENCODING_SHORT := "-e"
}
class OPT_HANDLER
{
	; lists options which require a value to be passed after them
	static VALUE_OPTIONS := [ OPT.REMOTE, OPT.REMOTE_SHORT
							, OPT.LIBDIR, OPT.LIBDIR_SHORT
							, OPT.DEPENDENCYLIBDIR, OPT.DEPENDENCYLIBDIR_SHORT
							, OPT.DEPENDENCIES_FROM, OPT.DEPENDENCIES_FROM_SHORT
							, OPT.AHKVERSION, OPT.AHKVERSION_SHORT
							, OPT.AHK_REVISION, OPT.AHK_REVISION_SHORT
							, OPT.ENCODING, OPT.ENCODING_SHORT ]
}