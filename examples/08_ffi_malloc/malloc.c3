module malloc_example;
import std::io;

extern fn void* malloc(usz size);
extern fn void free(void* ptr);

fn void main()
{
    void* ptr = malloc(100);
    if (ptr == null)
    {
        io::printn("malloc failed");
        return;
    }
    io::printfn("allocated 100 bytes at %p", ptr);
    free(ptr);
    io::printn("freed memory");
}
