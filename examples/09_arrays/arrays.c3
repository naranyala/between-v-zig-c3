module arrays;
import std::io;

fn void main()
{
    // Array declaration and initialization
    int[5] arr = { 1, 2, 3, 4, 5 };
    io::printfn("array: [%d, %d, %d, %d, %d]", arr[0], arr[1], arr[2], arr[3], arr[4]);
    io::printfn("length: %d", arr.len);

    // Access elements
    io::printfn("first: %d", arr[0]);
    io::printfn("last: %d", arr[arr.len - 1]);

    // Modify elements
    arr[0] = 10;
    io::printfn("after modify: [%d, %d, %d, %d, %d]", arr[0], arr[1], arr[2], arr[3], arr[4]);

    // Array iteration
    io::printn("iterating:");
    for (int i = 0; i < arr.len; i++)
    {
        io::printfn("  [%d] = %d", i, arr[i]);
    }

    // Array slicing (indices 1, 2, 3)
    io::printfn("slice [1..3]: [%d, %d, %d]", arr[1], arr[2], arr[3]);

    // Array sorting
    int[5] nums = { 5, 2, 8, 1, 9 };
    io::printfn("before sort: [%d, %d, %d, %d, %d]", nums[0], nums[1], nums[2], nums[3], nums[4]);

    // Simple bubble sort for demonstration
    for (int i = 0; i < nums.len; i++)
    {
        for (int j = 0; j < nums.len - 1; j++)
        {
            if (nums[j] > nums[j + 1])
            {
                int temp = nums[j];
                nums[j] = nums[j + 1];
                nums[j + 1] = temp;
            }
        }
    }
    io::printfn("sorted: [%d, %d, %d, %d, %d]", nums[0], nums[1], nums[2], nums[3], nums[4]);

    // Array contains
    bool found = false;
    for (int i = 0; i < nums.len; i++)
    {
        if (nums[i] == 5)
        {
            found = true;
            break;
        }
    }
    io::printfn("contains 5: %s", found ? "true" : "false");

    found = false;
    for (int i = 0; i < nums.len; i++)
    {
        if (nums[i] == 10)
        {
            found = true;
            break;
        }
    }
    io::printfn("contains 10: %s", found ? "true" : "false");
}
