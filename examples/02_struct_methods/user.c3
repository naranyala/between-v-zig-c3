module user;
import std::io;

struct User
{
	String name;
	int age;
}

fn void User.greet(User* self)
{
	io::printfn("Hello, my name is %s", self.name);
}

fn void main()
{
	User user = { .name = "Alice", .age = 30 };
	user.greet();
}
