module error;
import std::io;

faultdef DIVISION_BY_ZERO;

fn int? divide(int x, int y)
{
	if (!y) return DIVISION_BY_ZERO~;
	return x / y;
}

fn void main()
{
	int? x = divide(10, 2);
	if (catch err = x)
	{
		io::printfn("Error: '%s'", err);
		return;
	}
	io::printfn("Result: %d", x);
}
