module concurrency;
import std::io;

fn void worker(usz id)
{
    for (usz i = 0; i < 3; i++)
    {
        io::printfn("worker %d: iteration %d", id, i);
    }
    io::printfn("worker %d: done", id);
}

fn void main()
{
    io::printn("starting workers...");

    // C3 doesn't have built-in threads in stdlib
    // This demonstrates the concept without actual threading
    for (usz id = 0; id < 3; id++)
    {
        worker(id);
    }

    io::printn("all workers done");
}
