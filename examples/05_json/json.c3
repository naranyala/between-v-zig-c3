module json_example;
import std::io;
import std::encoding::json;
import std::collections::object;

fn void main()
{
	String data = "{\"name\": \"Alice\", \"age\": 30}";
	object::Object* obj = json::tparse(data)!!;

	String name = obj.get("name").s!!;
	int age = obj.get_int("age")!!;
	io::printfn("name: %s, age: %d", name, age);
}
