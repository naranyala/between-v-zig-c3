module file_io;
import std::io;
import std::io::file;

fn void main()
{
	char[]? text = file::load_temp("input.txt");
	if (catch err = text)
	{
		io::printfn("Error: %s", err);
		return;
	}
	io::printfn("%s", (String)text);
}
