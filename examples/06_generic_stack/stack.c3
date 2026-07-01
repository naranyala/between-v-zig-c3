module stack;
import std::io;

struct Stack
{
	int* elems;
	usz capacity;
	usz size;
}

fn void Stack.init(Stack* this)
{
	this.capacity = 16;
	this.size = 0;
	this.elems = malloc((sz)(int::size * this.capacity));
}

fn void Stack.deinit(Stack* this)
{
	free(this.elems);
}

fn void Stack.push(Stack* this, int element)
{
	if (this.capacity == this.size)
	{
		this.capacity *= 2;
		this.elems = realloc(this.elems, (sz)(int::size * this.capacity));
	}
	this.elems[this.size++] = element;
}

fn int? Stack.pop(Stack* this)
{
	if (this.size == 0) return {};
	return this.elems[--this.size];
}

fn void main()
{
	Stack stack;
	stack.init();
	defer stack.deinit();

	stack.push(10);
	stack.push(20);
	stack.push(30);

	while (stack.size > 0)
	{
		int val = stack.pop()!!;
		io::printfn("popped: %d", val);
	}
}
