module qsort;
import std::io;

extern fn void qsort(void* arr, usz count, usz size, void* compare);

fn int compare(void* a, void* b)
{
	return *(int*)a - *(int*)b;
}

fn void main()
{
	int[5] arr = { 5, 2, 8, 1, 9 };
	qsort(&arr, 5, int::size, &compare);

	for (int i = 0; i < 5; i++)
	{
		io::printfn("%d", arr[i]);
	}
}
