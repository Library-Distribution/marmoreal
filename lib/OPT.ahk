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

	static ENCODING := "--encoding"
	static ENCODING_SHORT := "-e"
}
class OPT_HANDLER
{
	; lists options whioch require a value to be passed after them
	static VALUE_OPTIONS := [ OPT.REMOTE, OPT.LIBDIR, OPT.DEPENDENCYLIBDIR, OPT.DEPENDENCIES_FROM, OPT.AHKVERSION, OPT.ENCODING ]
}