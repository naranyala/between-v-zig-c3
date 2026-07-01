module maps;
import std::io;

fn void main()
{
    // C3 doesn't have built-in hash maps in stdlib
    // This demonstrates the concept without actual maps
    io::printn("Map operations:");

    // Simulate map operations with parallel arrays
    String[4] keys = { "Alice", "Bob", "Charlie", "Diana" };
    int[4] values = { 30, 25, 35, 28 };

    io::printfn("Alice age: %d", values[0]);
    io::printfn("Bob age: %d", values[1]);

    // Modify
    values[0] = 31;
    io::printfn("after modify Alice: %d", values[0]);

    io::printn("map operations completed");
}
